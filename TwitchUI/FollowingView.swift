import SwiftUI

struct FollowingView: View {
    @ObservedObject var viewModel: FollowingViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack {
                        Image(uiImage: viewModel.userImage)
                        .resizable()
                        .clipShape(Circle())
                            .frame(width: 35, height: 35)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        Spacer()
                    }
                    Text("Following")
                        .font(.system(size: 40)).bold()
                        .foregroundColor(.white)
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.viewModel.getUser()
        }
    }
}

struct FollowingView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingView(viewModel: .init(currentUser: User.testUser, userImage: UIImage(named: "default") ?? UIImage()))
    }
}
