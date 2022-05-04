//
//  CircularProgress.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/29.
//

import Foundation
import SwiftUI

struct circlurProgress: View {
    @ObservedObject var goal: Goal
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 24.0)
                .opacity(0.2)
                .foregroundColor(Color("LightPastelBlue"))
            Circle()
                .trim(from: 0.00, to: (goal.getAvg() == 0 ? 0.1 : goal.getAvg()) / 100)
                .stroke(style: StrokeStyle(lineWidth: 24.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("LightPastelBlue"))
                .rotationEffect(.degrees(-90))
                .animation(.default, value: goal.getAvg())
            Text("\(Int(goal.getAvg()))%").foregroundColor(Color("LightGray"))
        }
        .frame(width: 136, height: 136)
        .padding()
    }
}
