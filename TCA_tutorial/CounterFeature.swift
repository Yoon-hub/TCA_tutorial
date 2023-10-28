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
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action { // 사용자의 이벤트를 정의하는 곳
        case decrementButtonTapped
        case incrementButtonTapped
        case fatchButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTicked
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.fact = nil
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.fact = nil
            state.count += 1
            return .none
        case .fatchButtonTapped:
            state.fact = nil
            state.isLoading = true
            
            return .run { [count = state.count] send in
              let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(count)")!)
              let fact = String(decoding: data, as: UTF8.self)
              await send(.factResponse(fact))
            }
        case let .factResponse(fact):
            state.fact = fact
            state.isLoading = false
            return .none
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            return .run { send in
                while true {
                    try await Task.sleep(for: .seconds(1))
                    await send(.timerTicked)
                }
            }
        case .timerTicked:
            state.count += 1
            state.fact = nil
            return .none
        }
    }
}
