//
//  Goal.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/29.
//

import Foundation
import SwiftUI

class Goals: ObservableObject {
    @Published private var goals: [Goal]
    
    init(goals: [Goal]) {
        self.goals = goals
    }
    
    func addGoal(newGoal: String) {
        DBHelper.shared.insertGoal(mainGoal: newGoal)
        goals.append(Goal(id: DBHelper.shared.getGoalId(mainGoal: newGoal), mainGoal: newGoal, subGoals: []))
    }
    
    func getGoal(index: Int) -> Goal {
        return goals[index]
    }
    
    func getGoals() -> [Goal] {
        return goals
    }
    
    func getIds() -> [Int] {
        var ids: [Int] = []
        for i in 0..<goals.count {
            ids.append(goals[i].getId())
        }
        return ids
    }
    
    func removeGoal(index: Int) {
        DBHelper.shared.deleteGoal(id: goals[index].getId())
        goals.remove(at: index)
    }
}

class Goal:ObservableObject {
    @Published private var mainGoal: String
    @Published private var id: Int
    @Published private var subGoals: [SubGoal]
    
    init(id: Int, mainGoal: String, subGoals: [SubGoal]) {
        self.id = id
        self.mainGoal = mainGoal
        self.subGoals = subGoals
    }
    
    func getId() -> Int {
        return id
    }
    
    func getMainGoal() -> String {
        return mainGoal
    }
    
    func getSubGoals() -> [SubGoal] {
        return subGoals
    }
    
    func getSubGoal(id: Int) -> SubGoal {
        return subGoals[id]
    }
    
    func setMainGoal(newGoal: String) {
        self.mainGoal = newGoal
        DBHelper.shared.updateGoal(id: id, mainGoal: newGoal)
    }
    
    func addSubGoal(mainGoalId: Int, subGoal: String, maxDegree: Int) {
        DBHelper.shared.insertSubGoal(mainGoalId: mainGoalId, subGoal: subGoal, maxDegree: maxDegree)
        subGoals.append(SubGoal(id: DBHelper.shared.getSubGoalId(subGoal: subGoal), mainGoalId: mainGoalId, subGoal: subGoal, maxDegree: maxDegree))
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
    
    func removeSubGoal(id: Int, subGoalIndex: Int) {
        subGoals.remove(at: subGoalIndex)
        DBHelper.shared.deleteSubGoal(id: id)
    }
}
