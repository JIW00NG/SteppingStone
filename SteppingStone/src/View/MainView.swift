//
//  MainView.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
