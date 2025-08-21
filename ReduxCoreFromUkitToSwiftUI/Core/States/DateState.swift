//
//  DateState.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore

struct DateState: Equatable {
    let current: Date
    
    static let initial = DateState(current: Date(timeIntervalSince1970: 0))
}

func reduce(_ state: DateState, with action: Action) -> DateState {
    switch action {
    case let action as Actions.UpdateDateMiddleware.UpdateCurrent:
        return DateState(current: action.date)

    default:
        return state
    }
}
