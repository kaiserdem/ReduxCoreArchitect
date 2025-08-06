//
//  CounterFeature.swift
//  ReduxCoreAdapter
//
//  Created by Yaroslav Golinskiy on 05/08/2025.
//

import ReduxCore
import SwiftUI
import Dependencies

enum CounterFeature {
    struct State {
        var count: Int = 0
        var isTimerRun: Bool = false
    }

    enum Action: ReduxCore.Action {
        case increment
        case decrement
        case timerToggle
        case timerTick
    }

    static let reducer: ReduxCore.Reducer<State> = { state, action in
        var state = state
        switch action as? Action {
        case .increment:
            state.count += 1
            return state
            
        case .decrement:
            state.count -= 1
            return state
            
        case .timerToggle:
            state.isTimerRun.toggle()
            return state
            
        case .timerTick:
            if state.isTimerRun {
                state.count += 1
            }
            return state
            
        case .none:
            return state
        }
    }
    
    
    
    // Простий middleware з continuousClock
    static let timerMiddleware: ReduxCore.Middleware<State> = { dispatch, action, oldState, newState in
        @Dependency(\.continuousClock) var clock
        
        switch action as? Action {
        case .timerToggle:
            if newState.isTimerRun {
                // Запускаємо таймер прямо з continuousClock
                Task {
                    for await _ in clock.timer(interval: .seconds(1)) {
                        dispatch(Action.timerTick)
                    }
                }
            }
            // Для зупинки таймера не потрібно нічого робити - Task завершиться сам
        default:
            break
        }
    }
}



struct CounterStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<CounterFeature.State>? = nil
}

extension EnvironmentValues {
    var counterStore: ObservableStore<CounterFeature.State>? {
        get { self[CounterStoreKey.self] }
        set { self[CounterStoreKey.self] = newValue }
    }
}

