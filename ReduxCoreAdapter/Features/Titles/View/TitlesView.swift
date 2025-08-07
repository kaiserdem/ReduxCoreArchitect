
import SwiftUI
import ReduxCore

struct TitlesView: View {
    @Environment(\.tabStore) private var store: ObservableStore<TabFeature.State>?

    var body: some View {
        ZStack {
            Color.green.opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                Text("Titles View")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                if let store = store {
                    if store.state.titlesState.isLoading {
                        ProgressView("Loading...")
                            .foregroundColor(.white)
                    } else {
                        VStack {
                            Text("Titles count: \(store.state.titlesState.titles.count)")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            ScrollView {
                                ForEach(store.state.titlesState.titles) { item in
                                    HStack {
                                        Text(item.title)
                                            .padding(.bottom, 10)
                                        Spacer()
                                    }
                                }
                            }
                            
                            if let error = store.state.titlesState.error {
                                Text("Error: \(error.localizedDescription)")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            
                            Button("Download Titles") {
                                store.dispatch(action: TabFeature.Action.titlesAction(.download))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                        }
                    }
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
