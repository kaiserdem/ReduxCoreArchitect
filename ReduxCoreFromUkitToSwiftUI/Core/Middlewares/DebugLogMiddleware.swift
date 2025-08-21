//
//  DebugLogMiddleware.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore
import os.log

struct DebugLogMiddleware {
    func middleware() -> Middleware<State> {
        { _, action, _, _ in
            switch action {
            case is Actions.UpdateDateMiddleware.UpdateCurrent:
                break
            default:
                os_log("%@",
                       log: OSLog(subsystem: Bundle.main.bundleIdentifier ?? "", category: ""),
                       type: .debug,
                       "✳️ \(String(reflecting: action).prefix(500))")
            }
        }
    }
}
