//
//  SteppingStoneApp.swift
//  SteppingStone
//
//  Created by JiwKang on 2023/04/30.
//

import SwiftUI

@main
struct SteppingStoneApp: App {

    var body: some Scene {
        WindowGroup {
            HomeView(goal: .constant(Goal(content: "정보처리기사 취득", subGaol: [
                NormalSubGoal(content: "실기 접수", deadline: "2023.06.30 23:59".toDate()),
                NumericalSubGoal(content: "실기 기출문제 풀기", maxDegree: 10)
            ])))
        }
    }
}
