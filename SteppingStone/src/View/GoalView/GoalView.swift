//
//  GoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import Foundation
import SwiftUI

struct GoalView: View {
    @State var isModalShown: Bool = false
    @ObservedObject var goal: Goal
    @State var index: Int
    
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
                                        isModalShown = true
                                    }) {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    
                                    Button(action: {
                                        goals.removeGoal(index: index)
                                        goal.objectWillChange.send()
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
                                SubGoalItem(goal: goal, goalIndex: index, subGoalIndex: index)
                            }
                            AddSubGoalButton(goals: goals, index: index)
                        }
                    }
                }.padding()
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .sheet(isPresented: $isModalShown) {
            NavigationView {
                EditGoalView(goalIndex: index,
                             isModalShown: $isModalShown,
                             editGoal: goal.getMainGoal())
            }
        }
    }
}
