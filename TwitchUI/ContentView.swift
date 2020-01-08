import SwiftUI
import Keys
import AuthenticationServices

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 50) {
                    Text("Welcome \nto Twitch")
                        .font(.system(size: 50)).bold()
                        .foregroundColor(.white)
                    VStack(spacing: 20) {
                        Button(action: viewModel.login, label: {
                            Text("Log in with Twitch")
                                .padding(.all)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color.purple)
                                .foregroundColor(Color.white)
                                .cornerRadius(8)
                        })
                    }
                    NavigationLink(destination: FollowingView(viewModel: .init(currentUser: User.defaultUser)), isActive: $viewModel.loggedIn) {
                        EmptyView()
                    }
                }
                .padding(.all, 40)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
