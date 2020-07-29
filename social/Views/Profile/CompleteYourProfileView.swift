import SwiftUI

struct CompleteYourProfileView: View {
    @ObservedObject  var userViewModel : UserObserver

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(userViewModel.allUser) { item in
                        if item.id != userId as? String ?? ""{
                        CardView(item: item)
                        }
                    }
                }
            }
            
        }
        .onAppear {
            userViewModel.getAllUsers()
        }
    }
}

//struct CompleteYourProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompleteYourProfileView()
//            .previewLayout(.sizeThatFits)
//    }
//}
