import SwiftUI

struct HButtonView: View {
    let buttons = ["square.grid.2x2", "person.crop.rectangle"]
    
    var body: some View {
        HStack {
            ForEach(buttons, id: \.self) { button in
                HStack {
                    Spacer()
                    Button(action: {
                        //
                    }) {
                        Image(systemName: button)
                            .font(.title)
                            .foregroundColor(Color(.label))
                    }
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct HButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HButtonView()
            .previewLayout(.sizeThatFits)
    }
}
