//
//  ContentView.swift
//  ReduxCoreAdapter
//
//  Created by Yaroslav Golinskiy on 05/08/2025.
//

import ReduxCore
import SwiftUI

struct CounterView: View {
    @StateObject private var observableStore = ObservableStore<CounterFeature.State>(
           store: Store<CounterFeature.State>(
               state: CounterFeature.State(),
               reducer: CounterFeature.reducer,
               middlewares: []
           )
       )

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
                

                Text("Count: \(observableStore.state.count)")
                    .font(.title)
                HStack {
                    Button("+") {
                        observableStore.dispatch(action: CounterFeature.Action.increment)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(.gray)
                    
                    Button("-") {
                        observableStore.dispatch(action: CounterFeature.Action.decrement)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(.gray)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

