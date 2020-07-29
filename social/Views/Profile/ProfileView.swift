import SwiftUI
import SDWebImageSwiftUI
struct ProfileView: View {
    
    @ObservedObject  var userViewModel = UserObserver()
    
    @State var grids = true
    @State var anotherView = false
    var columns : [GridItem] = [.init(.flexible()),.init(.flexible()),.init(.flexible())]
    
    
    var body: some View {
        
        GeometryReader { r in
            ScrollView(.vertical) {
                  
                    TopView(userViewModel: userViewModel)
                    BioView(userViewModel: userViewModel)
                        .frame( maxHeight: 150)
                        .padding([.trailing,.leading])
                    CompleteYourProfileView(userViewModel: userViewModel)
                        

                HStack {
                  
                        HStack {
                            Spacer()
                            Button(action: {
                                grids = true
                                anotherView = false
                            }) {
                                Image(systemName: "square.grid.2x2")
                                    .font(.title)
                                    .foregroundColor(Color(.label))
                            }
                            Spacer()
                        }
                    
                    
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            grids = false
                            anotherView = true
                            
                        }) {
                            Image(systemName: "person.crop.rectangle")
                                .font(.title)
                                .foregroundColor(Color(.label))
                        }
                        Spacer()
                    }
                
                }
                .padding()
                
                

               
                if grids {
                    ScrollView {
                                    LazyVGrid(columns: columns) {
                                        ForEach(userViewModel.singleUserData.posts ?? [Posts](),id:\.id) { index in
                                                 // Image("test")
                                            AnimatedImage(url: URL(string: index.pic ?? ""))
                                                    .resizable()
                                                    .clipShape(Rectangle())
                                                .onAppear {
                                                    print(1)
                                                }
                                                .frame(height: r.size.height / 4)
                                                    .cornerRadius(10)
                                        }
                                    }
                                }
                    .padding(.horizontal)
                } else if anotherView {
                 
                    ForEach(userViewModel.singleUserData.posts ?? [Posts]()) { item in
                        AnimatedImage(url: URL(string: item.pic ?? ""))
                                .resizable()
               
                            .frame(width:r.size.width - 20,height: r.size.height / 3)
                         
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                    
                    
                }
                

             
                
                    
                 
                  
                }
       
            .onAppear {
                userViewModel.getUser(userId: userId as? String ?? " ")
        }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
