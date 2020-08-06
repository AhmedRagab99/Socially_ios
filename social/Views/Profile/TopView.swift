import SwiftUI
import SDWebImageSwiftUI



enum ActiveSheet {
   case follower, following
}

struct TopView: View {
    @ObservedObject  var userViewModel:UserObserver
    
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .follower
    
    var body: some View {
        HStack {
            //Image("test")
            AnimatedImage(url:URL(string: userViewModel.singleUserData.user?.pic ?? ""))
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
                        .onTapGesture {
                            if userViewModel.singleUserData.user?.followers?.count != 0{
                                self.showSheet = true
                                self.activeSheet = .follower
                            }
                        }
                }
                
                VStack {
                    Text("\(userViewModel.singleUserData.user?.following?.count ?? 0)")
                        .bold()
                    Text("Following")
                        .bold()
                        .onTapGesture {
                            if userViewModel.singleUserData.user?.following?.count != 0{
                                self.showSheet = true
                                self.activeSheet = .following
                            }
                        }
                }
             
                
            }
            
        }
        .sheet(isPresented: $showSheet) {
            if self.activeSheet == .follower {
               FollowerView(userViewModel: userViewModel)
            }
            else {
              FollowingView(userViewModel: userViewModel)
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
