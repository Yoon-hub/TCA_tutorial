//
//  TCA_tutorialTests.swift
//  TCA_tutorialTests
//
//  Created by 윤제 on 11/30/23.
//

import ComposableArchitecture
import XCTest
@testable import TCA_tutorial

@MainActor
final class TCA_tutorialTests: XCTestCase {

    /// State 변화에 대한 테스트
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
    
    /// timer 테스트
    func testTimer() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.toggleTimerButtonTapped) { // effect에 대한 동작이 끝난 후 판단을 해야하는데 지속적으로 도니까 정상적으로 isTimerRunning이 ture인지 판단할 수 없다 왜? 언제 false 로 바뀔지 모르니께
            $0.isTimerRunning = true
        }
        
        await store.receive ({
            switch $0 {
            case .timerTicked:
                return true
            default:
                return false
            }
        }, timeout: .seconds(2)) { // 2초 안에 1이 안되면 실패로 간주한다.
            $0.count = 1
        }
        
        await store.send(.toggleTimerButtonTapped) { // 멈추어 주면 정상동작 
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
      let store = TestStore(initialState: CounterFeature.State()) {
        CounterFeature()
      } withDependencies: {
          $0.numberFact.fetch = { count in "\(count) is good number."} // 디펜던시 수정
      }
        
        await store.send(.factButtonTapped) {
          $0.isLoading = true
        }
        
        await store.receive({ action in
            switch action {
            case .factResponse:
                return true
            default:
                return false
            }
        }, timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "0 is good number."
        }
    }
    
}
