
import SwiftUI
import ReduxCore

struct TabView: View {
    @Environment(\.tabStore) private var store: ObservableStore<TabFeature.State>?
    
    var body: some View {
        if let store = store {
            SwiftUI.TabView(selection: Binding(
                get: { store.state.selectedTab },
                set: { newTab in
                    store.dispatch(action: TabFeature.Action.setSelectedTab(newTab))
                }
            )) {
                
                CounterView()
                    .tag(Tab.counter)
                    .tabItem {
                        Image(systemName: "number.circle")
                        Text("Counter")
                    }
                
                TitlesView()
                    .tag(Tab.titles)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Titles")
                    }
            }
        } else {
            Text("Store not found")
        }
    }
}
