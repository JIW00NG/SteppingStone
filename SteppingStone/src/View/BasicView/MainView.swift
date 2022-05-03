//
//  MainView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import Foundation
import SwiftUI

struct MainView: View {
    @ObservedObject var goals: Goals = Goals()
    @State var currentTab: Int = 0
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(getCurrentDate())").font(.headline)
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            TabView(selection: $currentTab) {
                ForEach(0..<goals.goals.count, id: \.self) { index in
                    GoalView(goal: goals.goals[index]).tag(index)
                }
                EmptyGoalView(goals: goals, index: 0, currentTab: $currentTab).tag(goals.goals.count)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

func getCurrentDate() -> String {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: currentDate)
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
