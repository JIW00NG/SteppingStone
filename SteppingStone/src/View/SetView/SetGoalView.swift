//
//  SetGoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import Foundation
import SwiftUI

struct SetGoalView: View {
    @State var dbHelper = DBHelper.shared
    @State var newGoal: String = ""
    @Binding var isModalShown: Bool
    @ObservedObject var goals: Goals
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("What is your Goal?").font(.headline)
                TextField("enter your main goal", text: $newGoal)
                    .navigationBarTitle("Set Goal", displayMode: .inline)
                    .navigationBarItems(trailing: Button("Done", action: {
                        if newGoal != "" {
                            goals.addGoal(newGoal: newGoal)
                            self.isModalShown = false
                            newGoal = ""
                            goals.objectWillChange.send()
                        }else {
                            // TODO
                            // 입력 안하면 못지나감
                        }
                    }))
                    .navigationBarItems(leading: Button("Cancel", action: {
                        self.isModalShown = false
                        newGoal = ""
                    }))
            }
        }
    }
}
