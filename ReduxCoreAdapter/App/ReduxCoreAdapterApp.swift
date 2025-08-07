
import SwiftUI
import ReduxCore

@main
struct ReduxCoreAdapterApp: App {
    
    private let tabStore = ObservableStore<TabFeature.State>(
        store: Store<TabFeature.State>(
            state: TabFeature.State(),
            reducer: TabFeature.reducer,
            middlewares: TabFeature.middlewares
        )
    )
    
    var body: some Scene {
        WindowGroup {
            TabView()
                .environment(\.tabStore, tabStore)
        }
    }
}
