//
//  Coordinator.swift
//  TCA_tutorial
//
//  Created by VP on 2023/10/30.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

struct Coordinator: Reducer {
    
    struct State: Equatable, IndexedRouterState {
        
        static let initialState = State (
            routes: [.root(.contacts(.init(
                contacts: [
                    Contact(name: "뭐요")
                ]
            )), embedInNavigationView: true)]
        )
        
        var routes: [Route<Screen.State>]
    }
    
    enum Action: IndexedRouterAction {
        case routeAction(Int, action: Screen.Action)
        case updateRoutes([Route<Screen.State>])
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .routeAction(_, action: .contacts(.detail(let contact))):
                state.routes.append(.push(.contactDetail(.init(contact: contact))))
               // return .none
            case .routeAction(_, action: .contactDetail(.backButtonTapped)):
                state.routes.pop()
               // return .none
            default:
                break
            }
            return .none
        }
        .forEachRoute {
          Screen()
        }
    }
}
