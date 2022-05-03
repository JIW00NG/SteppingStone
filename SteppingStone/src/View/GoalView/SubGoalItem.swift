//
//  subGoalItem.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/29.
//

import Foundation
import SwiftUI

var goalColors: [Color] = [
    Color("Pink"),
    Color("LightPurple"),
    Color("LightBeige")
]

struct SubGoalItem: View {
    @ObservedObject var goal: Goal
    @State var goalIndex: Int
    
    let goalsViewWidth = (UIScreen.main.bounds.width - 138)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(goalColors[goalIndex % 3])
            HStack {
                Button(action: {
                    goal.getSubGoals()[goalIndex].decreaseDegree()
                    goal.objectWillChange.send()
                }) {
                    Text("-").foregroundColor(.gray)
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))
                .frame(height: 64)
                
                ZStack(alignment: .leading) {
                    Rectangle().fill(.white.opacity(0.8))
                    
                    // TODO refactoring
                    if goal.getSubGoals().count > goalIndex {
                        VStack {
                            Rectangle().fill(goalColors[goalIndex % 3]).frame(width: (Double(goal.getSubGoals()[goalIndex].getDegree()) / Double(goal.getSubGoals()[goalIndex].getMaxDegree())) * goalsViewWidth)
                        }
                        .animation(.default, value: goal.getSubGoals()[goalIndex].getDegree())
                        
                        VStack(alignment: .leading) {
                            Text("\(goal.getSubGoals()[goalIndex].getSubGoal())").font(.subheadline)
                            Text("\(goal.getSubGoals()[goalIndex].getDegree())/\(goal.getSubGoals()[goalIndex].getMaxDegree())").font(.caption).foregroundColor(Color("LightGray"))
                        }.padding()
                    }
                }
                
                Button(action: {
                    goal.getSubGoals()[goalIndex].increaseDegree()
                    goal.objectWillChange.send()
                }) {
                    Text("+").foregroundColor(.gray)
                }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                .frame(height: 64)
            }
        }
        .frame(height: 64)
        
        .contextMenu {
            Button(action: {
                goal.removeSubGoal(index: goalIndex)
            }, label: {
                Text("Delete")
                Spacer()
                Image(systemName: "trash")
            })
        }
    }
}
