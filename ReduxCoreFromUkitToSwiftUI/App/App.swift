//
//  App.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import SwiftUI
import ReduxCore

/// Main SwiftUI App (replaces AppDelegate + SceneDelegate)
/// Головний SwiftUI App (замінює AppDelegate + SceneDelegate)
@main
struct ReduxCoreApp: App {
    
    // Global store instance (replaces StoreLocator.populate)
    // Глобальний екземпляр store (замінює StoreLocator.populate)
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
                // Інжектуємо store в Environment (замінює StoreLocator pattern)
                .environment(\.appStore, store)
        }
        // SwiftUI native lifecycle handling (better than NotificationCenter)
        // Нативне керування lifecycle в SwiftUI (краще ніж NotificationCenter)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                // App became active and ready for use
                // Додаток став активним і готовий до використання
                store.dispatch(action: Actions.AppLifecycle.DidBecomeActive())
            case .inactive:
                // App is inactive (during transitions)
                // Додаток неактивний (під час переходів)
                store.dispatch(action: Actions.AppLifecycle.WillResignActive())
            case .background:
                // App is in background
                // Додаток у фоновому режимі
                store.dispatch(action: Actions.AppLifecycle.DidEnterBackground())
            @unknown default:
                break
            }
        }
    }
    
    // SwiftUI scene phase monitoring (replaces AppDelegate lifecycle)
    // Моніторинг фази сцени SwiftUI (замінює lifecycle AppDelegate)
    @Environment(\.scenePhase) private var scenePhase
}
