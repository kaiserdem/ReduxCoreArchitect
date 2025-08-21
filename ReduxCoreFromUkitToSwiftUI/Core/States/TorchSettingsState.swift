//
//  TorchSettingsState.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore

struct TorchSettingsState: Equatable {
    let isEnabled: Bool
    
    static let initial = TorchSettingsState(isEnabled: false)
}

func reduce(_ state: TorchSettingsState, with action: Action) -> TorchSettingsState {
    switch action {
    case let action as Actions.FlashlightMiddleware.Changed:
        return TorchSettingsState(isEnabled: action.isEnabled)
    default:
        return state
    }
}
