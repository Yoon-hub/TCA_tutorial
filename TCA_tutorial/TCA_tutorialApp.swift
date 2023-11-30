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
    
    let store = Store(initialState: ContactsFeature.State(
        contacts: [
            Contact(name: "Blob"),
            Contact(name: "Blob Jr."),
            Contact(name: "Blob Sr."),
        ]
    )) {
        ContactsFeature()
    }
    
    var body: some Scene {
        WindowGroup {
//            CoordinatorView (
//                store: Store(initialState: .initialState, reducer: {
//                    Coordinator()
//                })
//            )
            CounterView(store: Store(initialState: CounterFeature.State(), reducer: {
                CounterFeature()
            }))
        }
    }
}
