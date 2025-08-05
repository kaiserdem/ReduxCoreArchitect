//
//  CounterFeature.swift
//  ReduxCoreAdapter
//
//  Created by Yaroslav Golinskiy on 05/08/2025.
//

import ReduxCore

enum CounterFeature {
    struct State {
        var count: Int = 0
    }

    enum Action: ReduxCore.Action {
        case increment
        case decrement
    }

    static let reducer: ReduxCore.Reducer<State> = { state, action in
        var state = state
        switch action as? Action {
        case .increment:
            state.count += 1
        case .decrement:
            state.count -= 1
        default:
            break
        }
        return state
    }
}
