//
//  MainView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import Foundation
import SwiftUI

struct MainView: View {
    @State var dbHelper = DBHelper.shared
    @State var currentTab: Int = 0
    @ObservedObject var goals: Goals = Goals(goals: DBHelper.shared.readGoalDataAll())
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(getCurrentDate())").font(.headline)
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            TabView(selection: $currentTab) {
                ForEach(goals.getGoals(), id: \.id) { goal in
                    GoalView(goal: goal)
                }
                EmptyGoalView(goals: goals).tag(goals.getGoals().count)
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
