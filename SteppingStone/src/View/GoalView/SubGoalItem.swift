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
    @State var dbHelper = DBHelper.shared
    @ObservedObject var goal: Goal
    @State var subGoalIndex: Int
    @State var isEditMode: Bool = false
    
    let goalsViewWidth = (UIScreen.main.bounds.width - 138)
    
    var body: some View {
        if isEditMode {
            EditSubGoalItem(goal: goal, isEditMode: $isEditMode, index: subGoalIndex, subGoal: goal.getSubGoal(id: subGoalIndex).getSubGoal(), maxDegree: goal.getSubGoal(id: subGoalIndex).getMaxDegree())
        }else {
            if goal.getSubGoals().count > subGoalIndex {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(goalColors[subGoalIndex % 3])
                    HStack {
                        Button(action: {
                            goal.getSubGoal(id: subGoalIndex).decreaseDegree()
                            goal.objectWillChange.send()
                        }) {
                            Text("-").foregroundColor(.gray)
                        }
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))
                        .frame(height: 64)
                        
                        ZStack(alignment: .leading) {
                            Rectangle().fill(.white.opacity(0.8))
                            
                            // TODO refactoring
                            
                            VStack {
                                Rectangle().fill(goalColors[subGoalIndex % 3]).frame(width: (Double(goal.getSubGoal(id: subGoalIndex).getDegree()) / Double(goal.getSubGoal(id: subGoalIndex).getMaxDegree())) * goalsViewWidth)
                            }
                            .animation(.default, value: goal.getSubGoal(id: subGoalIndex).getDegree())
                            VStack(alignment: .leading) {
                                Text("\(goal.getSubGoal(id: subGoalIndex).getSubGoal())").font(.subheadline)
                                Text("\(goal.getSubGoal(id: subGoalIndex).getDegree())/\(goal.getSubGoal(id: subGoalIndex).getMaxDegree())").font(.caption).foregroundColor(Color("LightGray"))
                            }.padding()
                            
                        }
                        
                        Button(action: {
                            goal.getSubGoal(id: subGoalIndex).increaseDegree()
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
                        isEditMode = true
                    }, label: {
                        Text("Edit")
                        Spacer()
                        Image(systemName: "pencil")
                    })
                    Button(action: {
                        goal.removeSubGoal(id: goal.getSubGoal(id: subGoalIndex).getId(), subGoalIndex: subGoalIndex)
                    }, label: {
                        Text("Delete")
                        Spacer()
                        Image(systemName: "trash")
                    })
                }
            }
        }
    }
}
