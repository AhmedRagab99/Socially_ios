import SwiftUI
import SDWebImageSwiftUI

struct TopView: View {
    @ObservedObject  var userViewModel:UserObserver
    var body: some View {
        HStack {
            //Image("test")
            AnimatedImage(url:URL(string: userPic as? String ?? "test"))
                .resizable()
                .clipShape(Circle())
                .frame(width: 80, height: 80)
                .padding(.trailing)
                .shadow(color:Color.primary.opacity(0.04),radius: 2)
            
            HStack {
                    VStack {
                        Text("\(userViewModel.singleUserData.posts?.count ?? 0)")
                            .bold()
                        Text("Posts")
                            .bold()
                    }
       
                VStack {
                    Text("\(userViewModel.singleUserData.user?.followers?.count ?? 0)")
                        .bold()
                    Text("Followers")
                        .bold()
                }
      
                VStack {
                    Text("\(userViewModel.singleUserData.user?.following?.count ?? 0)")
                        .bold()
                    Text("Following")
                        .bold()
                }
                   
            }
            
        }
     
    }
}

//struct TopView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
