//
//  GoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import Foundation
import SwiftUI

struct GoalView: View {
    @ObservedObject var goal: Goal
    
    var body: some View {
        VStack {
            ZStack (alignment: .top){
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color("StrokeColor"), lineWidth: 3)
                VStack {
                    VStack {
                        ZStack {
                            Text(goal.getMainGoal()).font(.headline).bold()
                            HStack {
                                Spacer()
                                Menu {
                                    Button(action: {
                                        
                                    }) {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    Button(action: {
                                        // todo: add main goal delete action
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                }
                            }
                        }
                        
                        circlurProgress(goal: goal)
                    }
                    
                    Divider()
                        .background(Color("StrokeColor"))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    ScrollView {
                        LazyVStack {
                            ForEach(0..<goal.getSubGoals().count, id: \.self) { index in
                                SubGoalItem(goal: goal, goalIndex: index)
                            }
                            AddSubGoalButton(goal: goal)
                        }
                    }
                }.padding()
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
