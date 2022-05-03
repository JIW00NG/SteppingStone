//
//  EmptyGoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/29.
//

import Foundation
import SwiftUI

struct EmptyGoalView: View {
    @State var isModalShown = false
    @State var newGoal: String = ""
    @ObservedObject var goals: Goals
    @Binding var currentTab: Int
    
    var body: some View {
        Button(action: {
            self.isModalShown = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color("StrokeColor"), lineWidth: 3)
                Image(systemName: "plus.circle").foregroundColor(Color("LightPastelBlue")).font(.title)
            }
        }.sheet(isPresented: self.$isModalShown) {
            NavigationView {
                SetGoalView(newGoal: $newGoal, isModalShown: $isModalShown, goals: goals)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
