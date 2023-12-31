//
//  ContentView.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/28.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack {
                Text("\(viewStore.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
              HStack {
                Button("-") {
                    viewStore.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)

                Button("+") {
                    viewStore.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
              }
                
                Button(viewStore.isTimerRunning ? "Stop timer" : "Start timer") {
                  viewStore.send(.toggleTimerButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)

                
                Button("Fact") {
                    viewStore.send(.factButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                if viewStore.isLoading {
                    ProgressView()
                } else if let fact = viewStore.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
            }
        }

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CounterView()
//    }
//}
