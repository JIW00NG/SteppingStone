//
//  SubGoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2023/04/30.
//

import SwiftUI

/// 서브 목표 표시 뷰
/// 큰 목표에 대한 세부 목표를 표시
///
/// 1. 세부 목표 달성 정도 표시 -> 달성 정도를 표시할 것인지 달성 완/미완을 표시할 것인지 정하기 -> 둘 다 가져가자 -> 수치적 목표는 달성 수치를 표시하고 미완/완 목표라면 달성 상태 표시
/// 2. 세부 목표 표시
/// 3. 세부 목표 수정 버튼

struct SubGoalView: View {
    @Binding var subGoal: SubGoal
    
    var body: some View {
        if subGoal is NormalSubGoal {
            NormalSubGoalView(normalSubGoal: Binding<NormalSubGoal>.constant(subGoal as! NormalSubGoal))
        } else if subGoal is NumericalSubGoal {
            NumericalSubGoalView(numericalSubGoal: Binding<NumericalSubGoal>.constant(subGoal as! NumericalSubGoal))
        }
    }
}

struct NormalSubGoalView: View {
    @Binding var normalSubGoal: NormalSubGoal
    
    var body: some View {
        HStack {
            Button(action: {
                normalSubGoal.isDone.toggle()
            }, label: {
                if normalSubGoal.isDone {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 1.5)
                            .foregroundColor(.accentColor)
                        Circle()
                            .foregroundColor(.accentColor)
                            .padding(3.5)
                    }
                } else {
                    Circle()
                        .stroke(lineWidth: 1.5)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                }
            })
            .frame(width: 24)
            .buttonStyle(.plain)
            
            Spacer()
            
            Text("\(normalSubGoal.content)")
                .strikethrough(normalSubGoal.isDone)
            
            Spacer()
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct NumericalSubGoalView: View {
    @Binding var numericalSubGoal: NumericalSubGoal
    
    var body: some View {
        HStack {
            Button(action: {
                numericalSubGoal.degree -= 1
            }, label: {
                Text("▼")
                    .font(.title)
                    .frame(width: 24)
            })
            .foregroundColor(numericalSubGoal.degree > 0 ? .accentColor : .gray)
            .opacity(numericalSubGoal.degree > 0 ? 1 : 0.5)
            .disabled(numericalSubGoal.degree > 0 ? false : true)
            .buttonStyle(.plain)
            
            Spacer()
            
            Text("\(numericalSubGoal.content) \(numericalSubGoal.degree)/\(numericalSubGoal.maxDegree)")
                .strikethrough(numericalSubGoal.degree == numericalSubGoal.maxDegree)
            
            Spacer()
            
            Button(action: {
                numericalSubGoal.degree += 1
            }, label: {
                Text("▲")
                    .font(.title)
                    .frame(width: 24)
            })
            .foregroundColor(numericalSubGoal.degree >= numericalSubGoal.maxDegree ? .gray : .accentColor)
            .opacity(numericalSubGoal.degree >= numericalSubGoal.maxDegree ? 0.5 : 1)
            .disabled(numericalSubGoal.degree >= numericalSubGoal.maxDegree ? true : false)
            .buttonStyle(.plain)
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct SubGoalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NormalSubGoalView(normalSubGoal: .constant(NormalSubGoal(content: "밥먹기", deadline: Date())))
            NumericalSubGoalView(numericalSubGoal: .constant(NumericalSubGoal(content: "돈모으기(만원)", deadline: Date(), maxDegree: 2)))
        }
    }
}
