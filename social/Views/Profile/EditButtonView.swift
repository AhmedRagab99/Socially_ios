import SwiftUI

struct EditButtonView: View {
    
    
    @ObservedObject var UserViewModel:UserObserver
    @State var userId:String
    @State var show:Bool
    var body: some View {
        Button(action: {
            //print("Edit")
            if !show {
                UserViewModel.followUser(followId: userId)
            } else {
                UserViewModel.unFollowUser(unfollowId: userId)
            }
        }) {
            
         
            if show {
                Text("Un Follow")
                        .bold()
                    .foregroundColor(Color.blue)
                    .font(.title)
            } else {
                Text("Follow")
                    .bold()
                .foregroundColor(Color.blue)
                    .font(.title)
            }
                }
            
        
        .frame(width: UIScreen.main.bounds.width - 60, height: 50)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

//struct EditButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditButtonView(UserViewModel: UserObserver(), userId: "")
//            .previewLayout(.sizeThatFits)
//    }
//}
