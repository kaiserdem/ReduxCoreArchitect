//
//  ReduxCoreAdapterApp.swift
//  ReduxCoreAdapter
//
//  Created by Yaroslav Golinskiy on 05/08/2025.
//

import SwiftUI
import ReduxCore

@main
struct ReduxCoreAdapterApp: App {
    
    private let store = ObservableStore<CounterFeature.State>(
        store: Store<CounterFeature.State>(
            state: CounterFeature.State(),
            reducer: CounterFeature.reducer,
            middlewares: [CounterFeature.timerMiddleware]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            CounterView()
                .environment(\.counterStore, store) 
        }
    }
}
