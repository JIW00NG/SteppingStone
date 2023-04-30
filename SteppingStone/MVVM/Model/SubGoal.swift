//
//  SubGoal.swift
//  SteppingStone
//
//  Created by JiwKang on 2023/04/30.
//

import Foundation

/// 변화를 감지할 건데 얘를 struct로 해야하나?
/// 1. viewmodel을 사용할 것이므로 class일 필요가 없다. OK

class SubGoal: Identifiable {
    let content: String
    let deadline: Date?
    
    init(content: String, deadline: Date? = nil) {
        self.content = content
        self.deadline = deadline
    }
    
    func getAchievementDegree() -> Float {
        return 0.0
    }
}

class NormalSubGoal: SubGoal {
    var isDone: Bool
    
    override init(content: String, deadline: Date? = nil) {
        self.isDone = true
        super.init(content: content, deadline: deadline)
    }
    
    override func getAchievementDegree() -> Float {
        return isDone ? 100 : 0
    }
}

class NumericalSubGoal: SubGoal {
    var degree: Int
    let maxDegree: Int
    
    init(content: String, deadline: Date? = nil, maxDegree: Int) {
        self.degree = 0
        self.maxDegree = maxDegree
        super.init(content: content, deadline: deadline)
    }
    
    override func getAchievementDegree() -> Float {
        return Float(degree) / Float(maxDegree) * 100
    }
}
