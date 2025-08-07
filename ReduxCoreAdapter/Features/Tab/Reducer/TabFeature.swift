
import SwiftUI
import ReduxCore

enum Tab {
    case counter
    case titles
}

struct TabFeature: Feature {
    
    struct State {
        var selectedTab: Tab = .counter
        var counterState: CounterFeature.State = .init()
        var titlesState: TitleFeature.State = .init()
    }
    
    enum Action: ReduxCore.Action {
        case setSelectedTab(Tab)
        case counterAction(CounterFeature.Action)
        case titlesAction(TitleFeature.Action)
    }
    
    static let reducer: ReduxCore.Reducer<State> = { state, action in
        var state = state
        
        switch action as? Action {
        case .setSelectedTab(let tab):
            state.selectedTab = tab
            return state
            
        case .counterAction(let counterAction):
            let newCounterState = CounterFeature.reducer(state.counterState, counterAction)
            state.counterState = newCounterState
            return state
            
        case .titlesAction(let titlesAction):
            let newTitlesState = TitleFeature.reducer(state.titlesState, titlesAction)
            state.titlesState = newTitlesState
            return state
            
        case .none:
            return state
        }
    }
    
    static let tabMiddleware: ReduxCore.Middleware<State> = { dispatch, action, oldState, newState in
        switch action as? Action {
        case .counterAction(let counterAction):
            for middleware in CounterFeature.middlewares {
                middleware(dispatch, counterAction, oldState.counterState, newState.counterState)
            }
            
        case .titlesAction(let titlesAction):
            for middleware in TitleFeature.middlewares {
                middleware(dispatch, titlesAction, oldState.titlesState, newState.titlesState)
            }
            
        default:
            break
        }
    }
    
    static var middlewares: [ReduxCore.Middleware<State>] {
        return [tabMiddleware]
    }
}

struct TabStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<TabFeature.State>? = nil
}

extension EnvironmentValues {
    var tabStore: ObservableStore<TabFeature.State>? {
        get { self[TabStoreKey.self] }
        set { self[TabStoreKey.self] = newValue }
    }
}
