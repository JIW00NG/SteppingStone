//
//  EmptyGoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/29.
//

import Foundation
import SwiftUI

struct EmptyGoalView: View {
    @State var isModalShown = false
    @ObservedObject var goals: Goals
    
    var body: some View {
        Button(action: {
            isModalShown = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color("StrokeColor"), lineWidth: 3)
                Image(systemName: "plus.circle").foregroundColor(Color("LightPastelBlue")).font(.title)
            }
        }.sheet(isPresented: $isModalShown) {
            NavigationView {
                SetGoalView(isModalShown: $isModalShown, goals: goals)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
