import SwiftUI
import SDWebImageSwiftUI
struct CardView: View {
    var item:User
    var body: some View {
        VStack {
           // Image("test")
            AnimatedImage(url: URL(string: item.pic ?? "test"))
                .resizable()
                .clipShape(Circle())
                .frame(width: 80, height: 80, alignment: .center)
              
                .padding(.top)
            
            Text("\(item.name ?? "user Name")")
                .bold()
                .padding()
            
            Text("\(item.pio ?? "new in Socially") ")
              
                .multilineTextAlignment(.center)
                .lineLimit(3)
            
            Button(action: {
                //
            }) {
                Text("Follow")
                    .bold()
                    .foregroundColor(.white)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.blue)
            .cornerRadius(12)
            .padding(.top)
        }
        .padding()
        .background(Color(.secondarySystemBackground))

        .cornerRadius(20)

        .padding()
      
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//            .previewLayout(.sizeThatFits)
//    }
//}


