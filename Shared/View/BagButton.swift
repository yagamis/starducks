import SwiftUI

struct BagButton: View {
    var body: some View {    
        Image("bag") //bag
            .renderingMode(.template)
            .frame(width: 74,height: 74)
            .overlay(
                RoundedRectangle(cornerRadius: 37)
                    .stroke(lineWidth: 3)
            )
    }
}

struct ShoppingBagView_Previews: PreviewProvider {
    static var previews: some View {
        BagButton()
    }
}
