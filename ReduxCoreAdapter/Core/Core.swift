//
//  Core.swift
//  ReduxCoreAdapter
//
//  Created by Yaroslav Golinskiy on 05/08/2025.
//

import Foundation
import ReduxCore
import Combine

final class ObservableStore<State>: ObservableObject {
    @Published private(set) var state: State
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

    deinit {
        cancellation?.cancel()
    }
}
