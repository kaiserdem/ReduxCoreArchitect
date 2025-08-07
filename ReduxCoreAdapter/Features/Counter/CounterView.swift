
import ReduxCore
import SwiftUI

struct CounterView: View {
    @Environment(\.tabStore) private var store: ObservableStore<TabFeature.State>?

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
                    Text("Count: \(store.state.counterState.count)")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Timer: \(store.state.counterState.isTimerRun ? "ON" : "OFF")")
                        .font(.headline)
                        .foregroundColor(store.state.counterState.isTimerRun ? .green : .red)
                        .padding(.bottom)
                    
                    HStack {
                        Button("+") {
                            store.dispatch(action: TabFeature.Action.counterAction(.increment))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        
                        Button("-") {
                            store.dispatch(action: TabFeature.Action.counterAction(.decrement))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                    }
                    
                    Button(store.state.counterState.isTimerRun ? "Stop Timer" : "Start Timer") {
                        store.dispatch(action: TabFeature.Action.counterAction(.timerToggle))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(store.state.counterState.isTimerRun ? Color.red.opacity(0.8) : Color.green.opacity(0.8))
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



