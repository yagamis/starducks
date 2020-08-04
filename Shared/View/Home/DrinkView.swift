import SwiftUI

struct DrinkView: View {
    let drink : Drink
    
    var body: some View {
        VStack(spacing: 15.0){
            ZStack {
                Image(drink.name)
                    .renderingMode(.template)
                    .frame(width: 64.0, height: 64.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(lineWidth: 2)
                    )
            }
            Text(LocalizedStringKey(drink.name))
        }
    }
}

struct DrinkView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            DrinkView(drink: drinksData[0])
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"zh"))
            DrinkView(drink: drinksData[1])
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"ja"))
            DrinkView(drink: drinksData[2])
                .previewLayout(.sizeThatFits)
        }
    }
}
