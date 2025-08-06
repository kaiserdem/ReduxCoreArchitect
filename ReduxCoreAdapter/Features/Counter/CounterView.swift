//
//  ContentView.swift
//  ReduxCoreAdapter
//
//  Created by Yaroslav Golinskiy on 05/08/2025.
//

import ReduxCore
import SwiftUI

struct CounterView: View {
    
    @Environment(\.counterStore) private var store: ObservableStore<CounterFeature.State>?

    var body: some View {
        ZStack {
            Color.blue.opacity(0.5)
                .ignoresSafeArea()
            VStack {
                Text("Counter View")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                if let store = store {
                    Text("Count: \(store.state.count)")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Timer: \(store.state.isTimerRun ? "ON" : "OFF")")
                        .font(.headline)
                        .foregroundColor(store.state.isTimerRun ? .green : .red)
                        .padding(.bottom)
                    
                    HStack {
                        Button("+") {
                            store.dispatch(action: CounterFeature.Action.increment)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        
                        Button("-") {
                            store.dispatch(action: CounterFeature.Action.decrement)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                    }
                    
                    Button(store.state.isTimerRun ? "Stop Timer" : "Start Timer") {
                        store.dispatch(action: CounterFeature.Action.timerToggle)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(store.state.isTimerRun ? Color.red.opacity(0.8) : Color.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top)
                } else {
                    Text("Store not found in Environment")
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

