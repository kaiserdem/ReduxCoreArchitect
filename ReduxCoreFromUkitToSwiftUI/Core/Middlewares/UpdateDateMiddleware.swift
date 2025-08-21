//
//  UpdateDateMiddleware.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore

// Actions moved to Core/Actions/Actions.swift to avoid duplication

struct UpdateDateMiddleware {
    func middleware(getDate: @escaping () -> Date = Date.init) -> Middleware<State> {
        var timer: Timer?
        // capture a reference to the outer variables that you happen to use inside the closure
        return { dispatch, action, _, _ in
            if timer == nil {
                let newTimer = Timer(timeInterval: 0.5, repeats: true) { _ in
                    dispatch(Actions.UpdateDateMiddleware.UpdateCurrent(date: getDate()))
                }
                RunLoop.main.add(newTimer, forMode: .common)
                timer = newTimer
            }
            
            switch action {
            case is Actions.AppLifecycle.DidBecomeActive,
                 is Actions.AppLifecycle.DidFinishLaunch,
                 is Actions.AppLifecycle.WillEnterForeground:
                dispatch(Actions.UpdateDateMiddleware.UpdateCurrent(date: getDate()))
            default:
                break
            }
        }
    }
}
