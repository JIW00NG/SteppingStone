//
//  GoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2023/04/30.
//

import SwiftUI

// 원형의 전체 목표 달성 정도 표시하는 뷰
// 1. 원형 프로그래스바
// 2. 달성도 표시 % label
// 3. 목표 수정 버튼

struct GoalView: View {
    @Binding var goal: Goal
    @State var goalDegree: Float = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke()
                .opacity(0.2)
            Circle()
                .trim(from: 0, to: CGFloat(goalDegree / 100))
                .stroke()
                .rotation(.degrees(-90))
            VStack {
                Text(goal.content)
                Text(String(format: "%0.2f", goalDegree))
                    .opacity(0.5)
            }
        }
        .padding()
        .onAppear {
            achivementDegree()
        }
        .frame(height: 200)
    }
    
    func achivementDegree() {
        goalDegree = 0.0
        goal.subGaol.forEach { subGoal in
            goalDegree += subGoal.getAchievementDegree()
        }
        goalDegree /= Float(goal.subGaol.count)
        print(goalDegree)
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(goal: .constant(Goal(content: "정보처리기사 취득", subGaol: [
            NormalSubGoal(content: "실기 접수", deadline: "2023.06.30 23:59".toDate()),
            NumericalSubGoal(content: "실기 기출문제 풀기", maxDegree: 10)])))
    }
}
