import SwiftUI

struct CompleteYourProfileView: View {
    @ObservedObject  var userViewModel : UserObserver
    @State var showSheet:Bool
    @State var userId = ""

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(userViewModel.allUser) { item in
                        if item.id != userViewModel.singleUserData.user?.id{
                            CardView(item: item, userViewModel: userViewModel)
                            .onTapGesture {
                                showSheet.toggle()
                                userId = item.id ?? ""
                            }
                            
                        }
                    }
                }
            }
            
        }
        .onAppear {
            userViewModel.getAllUsers()
        }
        .sheet(isPresented: $showSheet, onDismiss: {
            showSheet = false
        }) {
            ProfileView(ProfileUserId: userId)
                .padding(.top)
        }
        
    }
}

//struct CompleteYourProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompleteYourProfileView()
//            .previewLayout(.sizeThatFits)
//    }
//}
