
import SwiftUI
import Dependencies
import ReduxCore

struct LoginFeature: Feature {
    
    struct State {
        var isLoggedIn: Bool = false
        var email: String = ""
        var isValidEmail: Bool = false
    }
    
    enum Action: ReduxCore.Action {
        case setLogin
        case emailChange(String)
    }
    
    static var reducer: ReduxCore.Reducer<State> = { state, action in
        var state = state
        
        switch action as? Action {
        case .setLogin:
            state.isLoggedIn = true
            return state
            
        case .emailChange(let email):
            state.email = email
            state.isValidEmail = !state.email.isEmpty
            return state
            
        case .none:
            return state
        }
    }
}

struct LoginStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<LoginFeature.State>? = nil
}

extension EnvironmentValues {
    var loginStore: ObservableStore<LoginFeature.State>? {
        get { self[LoginStoreKey.self] }
        set { self[LoginStoreKey.self] = newValue }
    }
}

