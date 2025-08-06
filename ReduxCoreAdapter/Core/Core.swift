//
//  Core.swift
//  ReduxCoreAdapter
//
//  Created by Yaroslav Golinskiy on 05/08/2025.
//

import Foundation
import ReduxCore
import Combine
import SwiftUI

@Observable
final class ObservableStore<State> { //generic параметр, може бути будь-який тип стану
    private(set) var state: State
    private let store: Store<State>
    private var cancellation: Cancellation?

    init(store: Store<State>) {
        self.store = store
        self.state = store.state
        self.cancellation = store.observe { [weak self] state in // підписуємося на зміни стану в Redux Store
            DispatchQueue.main.async {
                self?.state = state
            }
        }
    }

    func dispatch(action: any ReduxCore.Action) {
        store.dispatch(action: action) // перенаправляє виклик до Redux Store
    }

    deinit {
        cancellation?.cancel() //коли ObservableStore знищується, скасовуємо підписку, запобігає memory leaks
    }
    
                            
                            
}


