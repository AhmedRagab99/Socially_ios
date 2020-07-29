import SwiftUI

struct InfoVStackView: View {
    let infos = [
        Info(number: 2, label: "Posts"),
        Info(number: 6, label: "Followers"),
        Info(number: 7, label: "Following")
    ]
    
    var body: some View {
     Text("asfdzfgsdfg")
    }
}

struct InfoVStackView_Previews: PreviewProvider {
    static var previews: some View {
        InfoVStackView()
            .previewLayout(.sizeThatFits)
    }
}

struct Info: Hashable {
    let number: Int
    let label: String
}
