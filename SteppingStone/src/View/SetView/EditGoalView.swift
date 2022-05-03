//
//  EditGoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/05/03.
//

import SwiftUI

struct EditGoalView: View {
    @ObservedObject var goal: Goal
    @Binding var isModalShown: Bool
    @State var editGoal: String
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("What is your Goal?").font(.headline)
                TextField("enter your main goal", text: $editGoal)
                    .navigationBarTitle("Edit Your Goal", displayMode: .inline)
                    .navigationBarItems(trailing: Button("Done", action: {
                        if editGoal != "" {
                            goal.setMainGoal(newGoal: editGoal)
                            editGoal = ""
                        }
                        self.isModalShown = false
                    }))
                    .navigationBarItems(leading: Button("Cancel", action: {
                        self.isModalShown = false
                        editGoal = ""
                    }))
            }
        }
    }
}
