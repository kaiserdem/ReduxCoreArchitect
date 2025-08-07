
import ReduxCore
import SwiftUI
import Dependencies

struct TitleFeature: Feature {
    
    struct State {
        var titles: [TitlesData] = []
        var isLoading: Bool = false
        var error: Error? = nil
    }
    
    enum Action: ReduxCore.Action {
        case download
        case downloadCompletion(TitlesData)
        case downloadError(Error)
    }
    
    static let reducer: ReduxCore.Reducer<State> = { state, action in
        var state = state
        
        switch action as? Action {
        case .download:
            print("📥 Download case")

            state.isLoading = true
            return state
            
        case .downloadCompletion(let title):
            
            state.titles.append(title)
            state.isLoading = false
            return state
            
        case .downloadError(let error):
            state.isLoading = false
            state.error = error
            return state
            
        case .none:
            return state
        }
    }
    
    static let titlesMiddleware: ReduxCore.Middleware<State> = { dispatch, action, oldState, newState in
        @Dependency(\.titlesEffect) var titlesEffect
        
        switch action as? Action {
        case .download:
            Task {
                do {
                    let id =  String(oldState.titles.count + 1)
                    let title = try await titlesEffect.getTitles(withId: id)
                    dispatch(TabFeature.Action.titlesAction(.downloadCompletion(title)))
                } catch {
                    dispatch(TabFeature.Action.titlesAction(.downloadError(error)))
                }
            }
        default:
            break
        }
    }
    
    static var middlewares: [ReduxCore.Middleware<State>] {
        return [titlesMiddleware]
    }
}


struct TitleStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<TitleFeature.State>? = nil
}

extension EnvironmentValues {
    var titleStore: ObservableStore<TitleFeature.State>? {
        get { self[TitleStoreKey.self] }
        set { self[TitleStoreKey.self] = newValue }
    }
}
