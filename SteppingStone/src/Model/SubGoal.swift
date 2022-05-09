//
//  SubGoal.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/05/02.
//

import Foundation

class SubGoal: ObservableObject {
    @Published private var id: Int
    @Published private var mainGoalId: Int
    @Published private var subGoal: String
    @Published private var degree: Int
    @Published private var maxDegree: Int
    
    init(id: Int, mainGoalId: Int, subGoal: String, maxDegree: Int) {
        self.id = id
        self.mainGoalId = mainGoalId
        self.subGoal = subGoal
        self.degree = 0
        self.maxDegree = maxDegree
    }
    
    func getId() -> Int {
        return Int(DBHelper.shared.readSubGoalData(id: id, key: "id"))!
    }
    
    func getMainGoalId() -> Int {
        return Int(DBHelper.shared.readSubGoalData(id: id, key: "main_goal_id"))!
    }
    
    func getSubGoal() -> String {
        return DBHelper.shared.readSubGoalData(id: id, key: "sub_goal")
    }
    
    func getDegree() -> Int {
        return Int(DBHelper.shared.readSubGoalData(id: id, key: "degree"))!
    }
    
    func getMaxDegree() -> Int {
        return Int(DBHelper.shared.readSubGoalData(id: id, key: "max_degree"))!
    }
    
    func setSubGoal(newSubGoal: String) {
        subGoal = newSubGoal
    }
    
    func setDegree(newDegree: Int) {
        degree = newDegree
    }
    
    func setMaxDegree(newMaxDegree: Int) {
        maxDegree = newMaxDegree
    }
    
    func increaseDegree() {
        if getDegree() < getMaxDegree() {
            degree += 1
            DBHelper.shared.increaseDegree(id: id)
        }
    }
    
    func decreaseDegree() {
        if getDegree() > 0 {
            degree -= 1
            DBHelper.shared.decreaseDegree(id: id)
        }
    }
}
