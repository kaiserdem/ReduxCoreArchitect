
import SwiftUI
import ReduxCore

@main
struct ReduxCoreAdapterApp: App {

    private let mainStore = ObservableStore<MainFeature.State>(
        store: Store<MainFeature.State>(
            state: MainFeature.State(),
            reducer: MainFeature.reducer,
            middlewares: MainFeature.middlewares
        )
    )
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.mainStore, mainStore)
        }
    }
}
