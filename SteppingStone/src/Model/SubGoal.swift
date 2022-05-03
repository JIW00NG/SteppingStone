//
//  SubGoal.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/05/02.
//

import Foundation

class SubGoal {
    @Published private var subGoal: String
    @Published private var degree: Int
    @Published private var maxDegree: Int
    
    init(subGoal: String, maxDegree: Int) {
        self.subGoal = subGoal
        self.degree = 0
        self.maxDegree = maxDegree
    }
    
    func getSubGoal() -> String {
        return subGoal
    }
    
    func getDegree() -> Int {
        return degree
    }
    
    func getMaxDegree() -> Int {
        return maxDegree
    }
    
    func increaseDegree() {
        if degree < maxDegree {
            degree += 1
        }
    }
    
    func decreaseDegree() {
        if degree > 0 {
            degree -= 1
        }
    }
}
