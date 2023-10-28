//
//  CounterFeature.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/28.
//

import Foundation
import ComposableArchitecture

struct CounterFeature: Reducer {
    
    struct State: Equatable { // UI를 렌더링하는데 필요한 데이터를 관리한다.
        var count = 0
    }
    
    enum Action { // 사용자의 이벤트를 정의하는 곳
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
}
