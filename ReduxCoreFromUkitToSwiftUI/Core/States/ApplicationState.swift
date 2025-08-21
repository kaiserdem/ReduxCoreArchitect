//
//  ApplicationState.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore

enum ApplicationState: Equatable {
    case active
    case inactive
    case background
    
    static let initial = ApplicationState.active
}

func reduce(_ state: ApplicationState, with action: Action) -> ApplicationState {
    switch action {
    case is Actions.AppLifecycle.DidEnterBackground:
        return .background
    case is Actions.AppLifecycle.DidBecomeActive:
        return .active
    case is Actions.AppLifecycle.WillResignActive:
        return .inactive
    default:
        return state
    }
}
