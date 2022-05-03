//
//  Goal.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/29.
//

import Foundation
import SwiftUI

class Goals:ObservableObject {
    @Published public var goals: [Goal]
    
    init() {
        self.goals = []
    }
    
    init(goals: [Goal]) {
        self.goals = goals
    }
}

class Goal:ObservableObject {
    @Published private var mainGoal: String
    @Published private var subGoals: [SubGoal]
    
    init(mainGoal: String) {
        self.mainGoal = mainGoal
        self.subGoals = []
    }
    
    init(mainGoal: String, subGoal: [SubGoal]) {
        self.mainGoal = mainGoal
        self.subGoals = subGoal
    }

    func addSubGoal(subGoal: String, maxDegree: Int) {
        subGoals.append(SubGoal(subGoal: subGoal, maxDegree: maxDegree))
    }

    func getMainGoal() -> String {
        return mainGoal
    }
    
    func setMainGoal(newGoal: String) {
        self.mainGoal = newGoal
    }
    
    func getSubGoals() -> [SubGoal] {
        return subGoals
    }
    
    func getSubGoalDegree(index: Int) -> Int {
        return subGoals[index].getDegree()
    }
    
    func getSubGoalMaxDegree(index: Int) -> Int {
        return subGoals[index].getMaxDegree()
    }

    func getAvg() -> Double {
        var avg: Double = 0
        if subGoals.count == 0 {
            return 0
        } else {
            for i in 0..<subGoals.count {
                avg += Double(subGoals[i].getDegree()) / Double(subGoals[i].getMaxDegree())
            }
            return avg / Double(subGoals.count) * 100
        }
    }
    
    func removeSubGoal(index: Int) {
        subGoals.remove(at: index)
    }
}
