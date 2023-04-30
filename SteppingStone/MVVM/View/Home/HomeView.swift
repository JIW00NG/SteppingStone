//
//  MainView.swift
//  SteppingStone
//
//  Created by JiwKang on 2023/04/30.
//

import SwiftUI

struct HomeView: View {
    // TODO: 나중에 user default 설정으로 앱 종료시 보고있던 페이지 보여주기
    @State var currentPage: Int = 0
    @Binding var goal: Goal
    
    var body: some View {
        VStack {
            GoalView(goal: $goal)
            List(goal.subGaol.indices, id: \.self){ i in
                SubGoalView(subGoal: $goal.subGaol[i])
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(goal: .constant(Goal(content: "정보처리기사 취득", subGaol: [
            NormalSubGoal(content: "실기 접수", deadline: "2023.06.30 23:59".toDate()),
            NumericalSubGoal(content: "실기 기출문제 풀기", maxDegree: 10)
        ])))
    }
}
