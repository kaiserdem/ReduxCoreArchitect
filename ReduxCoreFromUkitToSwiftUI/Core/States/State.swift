//
//  State.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore

struct State {
    let application: ApplicationState
    let date: DateState
    let torchSettings: TorchSettingsState
    
    static let initial = State(
        application: ApplicationState.initial,
        date: DateState.initial,
        torchSettings: TorchSettingsState.initial
    )
}

func reduce(_ state: State, with action: Action) -> State {
    State(
        application: reduce(state.application, with: action),
        date: reduce(state.date, with: action),
        torchSettings: reduce(state.torchSettings, with: action)
    )
}
