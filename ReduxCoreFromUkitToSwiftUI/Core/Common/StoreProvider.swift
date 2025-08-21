//
//  StoreProvider.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import SwiftUI
import ReduxCore

/// Type alias to avoid conflict with SwiftUI's @State
/// Псевдонім типу для уникнення конфлікту з SwiftUI @State
typealias AppState = State

/// ObservableStore for SwiftUI integration
/// Replaces the StoreLocator pattern with Environment-based injection
/// ObservableStore для інтеграції з SwiftUI
/// Замінює паттерн StoreLocator на інжекцію через Environment
@Observable
final class ObservableStore<State> {
    private(set) var state: State
    private let store: Store<State>
    private var cancellation: Cancellation?
    
    init(store: Store<State>) {
        self.store = store
        self.state = store.state
        self.cancellation = store.observe { [weak self] state in
            DispatchQueue.main.async {
                self?.state = state
            }
        }
    }
    
    func dispatch(action: any ReduxCore.Action) {
        store.dispatch(action: action)
    }
    
    /// Dispatch command without parameters
    /// Відправка команди без параметрів
    func dispatch(command: Command) {
        command.perform()
    }
    
    /// Dispatch command with parameters
    /// Відправка команди з параметрами
    func dispatch<T>(command: CommandWith<T>, with value: T) {
        command.perform(with: value)
    }
    
    deinit {
        cancellation?.cancel()
    }
}

// MARK: - Environment for global state access
// MARK: - Environment для глобального доступу до стану

/// Environment key for the app store
/// Ключ Environment для app store
struct AppStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<AppState>? = nil
}

extension EnvironmentValues {
    var appStore: ObservableStore<AppState>? {
        get { self[AppStoreKey.self] }
        set { self[AppStoreKey.self] = newValue }
    }
}
