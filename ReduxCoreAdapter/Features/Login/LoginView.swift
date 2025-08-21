
import SwiftUI
import Dependencies
import ReduxCore

struct LoginView: View {
    
    @Environment(\.loginStore) private var store: ObservableStore<LoginFeature.State>!

    var body: some View {
        VStack {
            Text("Login View")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            TextField("Email", text: Binding(
                           get: { store?.state.email ?? "" },
                           set: { store?.dispatch(action: LoginFeature.Action.emailChange($0)) }
                       ))
                       .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Login") {
                store?.dispatch(action: LoginFeature.Action.setLogin) // спрацбовує тільки LoginFeature
                store?.dispatch(action: MainFeature.Action.loginAction(.setLogin)) // нічого не спрацбовує

                
            }
            .disabled(!store.state.isValidEmail)
            .modifier(ButtonStyle())
            .border(store.state.isValidEmail ? .blue : .gray)
            
            Spacer()

        }
        .padding()
    }
}

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
    }
}
