//
//  MainView.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import SwiftUI
import ReduxCore
import Foundation
import Combine

/// SwiftUI version of MainViewController
/// Displays current time and torch toggle button
struct MainView: View {
    // Store injection through Environment
    @Environment(\.appStore) private var store: ObservableStore<AppState>?
    
    // Timer publisher for SwiftUI (better approach than @State Timer)
    private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    // Date formatter (same as in MainViewPresenter)
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    var body: some View {
        // Temporary simple view while fixing type resolution
        VStack {
            Text("Redux Core SwiftUI")
                .font(.largeTitle)
                .padding()
            
            Text("MainView working!")
                .foregroundColor(.blue)
            
            if let store = store {
                Text("Store connected!")
                    .foregroundColor(.green)
            } else {
                Text("Store not connected")
                    .foregroundColor(.red)
            }
        }
        .onReceive(timer) { _ in
            // Update date every 0.5 seconds using Timer publisher
            // TODO: Restore once Actions are available
            // store?.dispatch(action: Actions.UpdateDateMiddleware.UpdateCurrent(date: Date()))
        }
    }
}

// Preview removed due to State import complexity
// MainView can be tested through App.swift with real store
