//
//  GoalView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import Foundation
import SwiftUI

struct GoalView: View {
    var body: some View {
        VStack {
            Text("Aug 28, 2022").font(.title)
            ZStack (alignment: .top){
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                    .foregroundColor(Color("StrokeColor"))
                LazyVStack {
                    Text("실리콘벨리에서 일하고 싶다").font(.subheadline).bold()

                    // TODO add progress bar
                    ProgressView(value: 0.42)

                    Divider().padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).background(Color("StrokeColor"))

                    List {
                        ForEach(0..<5) { _ in
                            subGoalItem()
                                .listRowSeparator(.hidden).frame(width: .infinity)
                        }
                    }
                    .listStyle(.plain)
                    .frame(width: .infinity, height: 500)
                }.padding()
            }
        }.padding()
    }
}

struct subGoalItem: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Pink"))
            HStack {
                Button(action: {
                    
                }) {
                    Text("-").foregroundColor(.gray)
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))
                
                ZStack {
                    Rectangle().fill(.white.opacity(0.7))
                }
                
                
                Button(action: {
                    
                }) {
                    Text("+").foregroundColor(.gray)
                }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
            }
        }.frame(height: 72)
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
