//
//  TCA_tutorialApp.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/28.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_tutorialApp: App {
    
    let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: store)
        }
    }
}
