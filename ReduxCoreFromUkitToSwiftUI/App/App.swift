//
//  App.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import SwiftUI
import ReduxCore

/// Main SwiftUI App (replaces AppDelegate + SceneDelegate)
@main
struct ReduxCoreApp: App {
    
    // Global store instance (replaces StoreLocator.populate)
    private let store = ObservableStore<AppState>(
        store: Store<AppState>(
            state: AppState.initial,
            reducer: reduce,
            middlewares: [
                DebugLogMiddleware().middleware(),
                FlashlightMiddleware().middleware(),
                UpdateDateMiddleware().middleware()
            ]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            MainView()
                // Inject store into Environment (replaces StoreLocator pattern)
                .environment(\.appStore, store)
        }
        // SwiftUI native lifecycle handling (better than NotificationCenter)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                // App became active and ready for use
                store.dispatch(action: Actions.AppLifecycle.DidBecomeActive())
            case .inactive:
                // App is inactive (during transitions)
                store.dispatch(action: Actions.AppLifecycle.WillResignActive())
            case .background:
                // App is in background
                store.dispatch(action: Actions.AppLifecycle.DidEnterBackground())
            @unknown default:
                break
            }
        }
    }
    
    // SwiftUI scene phase monitoring (replaces AppDelegate lifecycle)
    @Environment(\.scenePhase) private var scenePhase
}
