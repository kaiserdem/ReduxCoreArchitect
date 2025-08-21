//
//  MainView.swift
//  ReduxCoreAdapter
//
//  Created by Yaroslav Golinskiy on 07/08/2025.
//

import SwiftUI
import Dependencies
import ReduxCore

struct MainView: View {
    @Environment(\.mainStore) private var store : ObservableStore<MainFeature.State>!
    var body: some View {
        VStack {
            if store.state.isLoggedIn {
                TabView()
                    .environment(\.tabStore, ObservableStore<TabFeature.State>(
                        store: Store<TabFeature.State>(
                            state: store.state.tabState,
                            reducer: TabFeature.reducer,
                            middlewares: TabFeature.middlewares
                        )
                    ))
            } else {
                LoginView()
                    .environment(\.loginStore, ObservableStore<LoginFeature.State>(
                        store: Store<LoginFeature.State>(
                            state: LoginFeature.State(),
                            reducer: LoginFeature.reducer,
                            middlewares: LoginFeature.middlewares
                        )
                    ))
            }
        }
    }
}


struct MainFeature: Feature {
    
    struct State {
        var isLoggedIn: Bool = false
        var loginState: LoginFeature.State = .init()
        var tabState: TabFeature.State = .init()
    }
    
    enum Action: ReduxCore.Action {
        case setMainLogin(Bool)
        case loginAction(LoginFeature.Action)
        case tabAction(TabFeature.Action)
    }
    
    static var reducer: ReduxCore.Reducer<State> = { state, action in
        var state = state
        
        switch action as? Action {
        case .setMainLogin(let login):
            state.isLoggedIn = login
            return state
            
        case .loginAction(let loginAction):
            let feature = LoginFeature.reducer(state.loginState, loginAction)
            state.loginState = feature
            
            if case .setLogin = loginAction {
                state.isLoggedIn = true 
            }
            
            if feature.isLoggedIn {
                state.isLoggedIn = true
            }
            
            return state
        
        case .tabAction(let tabAction):
            let feature = TabFeature.reducer(state.tabState, tabAction)
            state.tabState = feature
            return state
            
        case .none:
            return state
        }
    }
    
    static let mainMiddleware: ReduxCore.Middleware<State> = { dispatch, action, oldState, newState in
        switch action as? Action {
        case .loginAction(let loginAction):
            for middleware in LoginFeature.middlewares {
                middleware(dispatch, loginAction, oldState.loginState, newState.loginState)
            }
            
        case .tabAction(let tabAction):
            for middleware in TabFeature.middlewares {
                middleware(dispatch, tabAction, oldState.tabState, newState.tabState)
            }
            
        default:
            break
        }
    }

    static var middlewares: [ReduxCore.Middleware<State>] {
        return [mainMiddleware]
    }

}

struct MainStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<MainFeature.State>? = nil
}

extension EnvironmentValues {
    var mainStore: ObservableStore<MainFeature.State>? {
        get { self[MainStoreKey.self] }
        set { self[MainStoreKey.self] = newValue }
    }
}
