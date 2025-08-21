//
//  Redux.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

/// Global Redux exports
/// This file re-exports all Redux types to make them available throughout the app

// Re-export ReduxCore
@_exported import ReduxCore

// Re-export common types (no need to re-export, they're already global)
// State, reduce, and other global functions are automatically available

// Re-export Actions namespace
// Actions enum is already global

// Re-export ObservableStore through StoreProvider
// ObservableStore class is already global
