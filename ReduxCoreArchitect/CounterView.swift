//
//  CounterView.swift
//  ReduxCoreArchitect
//
//  Created by Yaroslav Golinskiy on 05/08/2025.
//

import SwiftUI
import ReduxCore

struct ContentView: View {
    @State private var count: Int = 0
    @State private var cancellation: Cancellation?
    
    let store = Store<CounterState>(
        state: CounterState(),
        reducer: counterReducer,
        middlewares: []
    )
    
    var body: some View {
        VStack {
            Text("Count: \(count)")
            
            HStack {
                Button("+") {
                    store.dispatch(action: CounterAction.decrement)
                }
                Button("-") {
                    store.dispatch(action: CounterAction.increment)
                }
            }
        }
        .onAppear {
            self.cancellation = store.observe { state in
                DispatchQueue.main.async {
                    self.count = state.count
                }
            }
        }
        .onDisappear {
            self.cancellation?.cancel()
        }
    }
}


struct CounterState {
    var count: Int = 0
}

enum CounterAction: ReduxCore.Action {
    case increment
    case decrement
}

let counterReducer: ReduxCore.Reducer<CounterState> = { state, action in
    var state = state
    switch action as? CounterAction {
    case .increment:
        state.count += 1
    case .decrement:
        state.count -= 1
    default:
        break
    }
    return state
}
