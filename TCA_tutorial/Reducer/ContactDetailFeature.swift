//
//  ContactDetailFeature.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/29.
//

import ComposableArchitecture

struct ContactDetailFeature: Reducer {
    
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action: Equatable {
        case backButtonTapped
        case funck
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backButtonTapped:
                return .none
            case .funck:
                print("ㅗㅗㅗ")
                return .none
            }
        }
    }
    
}
