//
//  MainScreenFactory.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

// MARK: - This file is deprecated for SwiftUI migration
// MainScreenFactory was used for UIKit dependency injection and storyboard loading
// In SwiftUI, we use Environment instead of factories
// 
// This functionality is now handled by:
// 1. App.swift - creates ObservableStore
// 2. MainView.swift - SwiftUI view with @Environment
// 3. StoreProvider.swift - Environment injection
//
// TODO: Remove this file after migration is complete

import Foundation

// Keeping minimal content to avoid build errors
// Will be removed once SwiftUI migration is complete
