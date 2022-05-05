//
//  GoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import Foundation
import SwiftUI

struct GoalView: View {
    @State var dbHelper = DBHelper.shared
    @State var isModalShown: Bool = false
    @ObservedObject var goals: Goals
    @State var index: Int
    
    var body: some View {
        VStack {
            ZStack (alignment: .top){
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color("StrokeColor"), lineWidth: 3)
                VStack {
                    VStack {
                        ZStack {
                            Text(goals.getGoal(index: index).getMainGoal()).font(.headline).bold()
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
                                        goals.objectWillChange.send()
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                }
                            }
                        }
                        
                        circlurProgress(goal: goals.getGoal(index: index))
                    }
                    
                    Divider()
                        .background(Color("StrokeColor"))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    ScrollView {
                        LazyVStack {
                            ForEach(0..<goals.getGoal(index: index).getSubGoals().count, id: \.self) { index in
                                SubGoalItem(goal: goals.getGoal(index: self.index), goalIndex: index, subGoalIndex: index)
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
                EditGoalView(goals: goals,
                             goalIndex: index,
                             isModalShown: $isModalShown,
                             editGoal: goals.getGoal(index: index).getMainGoal())
            }
        }
    }
}
