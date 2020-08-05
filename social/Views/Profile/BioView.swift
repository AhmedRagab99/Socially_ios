import SwiftUI

struct BioView: View {
    @ObservedObject  var userViewModel :UserObserver

    var body: some View {
        HStack {
            VStack(alignment: .leading) {

               
             
                Text("\(userViewModel.singleUserData.user?.name ?? " ")")
                    .font(.title)
                    
                Text("Bio :")
                    .foregroundColor(Color.blue)
                    .font(.subheadline)
                   
                Text("\(userViewModel.singleUserData.user?.pio ?? userPio as? String ?? "I am a IOS dev with a great pasion to learn")")
              
            }
            Spacer()
        }
        .padding()
    }
}
//
//struct BioView_Previews: PreviewProvider {
//    static var previews: some View {
//        BioView()
//            .previewLayout(.sizeThatFits)
//    }
//}
