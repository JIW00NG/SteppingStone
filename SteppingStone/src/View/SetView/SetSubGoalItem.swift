//
//  SetSubGoalItem.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/30.
//

import Foundation
import SwiftUI

struct SetSubGoalItem: View {
    @ObservedObject var goal: Goal
    @Binding var isAddMode: Bool
    
    @State var subGoal: String = ""
    @State var maxDegree: Int = 20
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TextField("set sub goal", text: $subGoal)
                    Divider()
                    Picker("set max degree", selection: $maxDegree) {
                        ForEach(1...100, id: \.self) { maxDegree in
                            Text("\(maxDegree)").tag(maxDegree)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                HStack {
                    Button(action: {
                        if subGoal != "" {
                            isAddMode.toggle()
                            goal.addSubGoal(subGoal: subGoal, maxDegree: maxDegree)
                            subGoal = ""
                            maxDegree = 20
                        } else {
                            // TODO sub goal이 정해지지 않았다는 알림창 띄우기
                        }
                    }) {
                        Text("Add")
                    }
                    
                    Divider()
                    
                    Button(action: {
                        isAddMode.toggle()
                    }) {
                        Text("Cancel")
                    }
                }.padding(.leading).padding(.trailing)
            }.padding()
            
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color("LightPastelBlue"), lineWidth: 3)
        }
        .frame(height: 84)
    }
}

struct AddSubGoalButton: View {
    @ObservedObject var goal: Goal
    @State var isAddMode: Bool = false
    
    var body: some View {
        
        if isAddMode {
            SetSubGoalItem(goal: goal, isAddMode: $isAddMode)
                .frame(height: 96)
        }
        
        Button(action: {
            // subgoal 작성 및 최대 range 지정하고 저장하기
            isAddMode.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color("LightPastelBlue"), lineWidth: 3)
                Image(systemName: "plus.circle").foregroundColor(Color("LightPastelBlue")).font(.title3)
            }
        }
        .listRowSeparator(.hidden)
        .frame(height: 64)
    }
}
