import SwiftUI

struct MenuTitleView: View {
    var menu : DrinkMenu
    
    var body: some View {
        VStack(alignment: .center) {
                Spacer()
 
                HStack {
                    Text("现在下单")
                        .font(.system(size: 21))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("subText"))
                    Image("arrow")
                }
           
            
                Text(menu.name.description)
                    .font(.system(size: 32))
                    .foregroundColor(.accentColor)
                    .fontWeight(.heavy)
            
                Spacer()
                
                PriceLabel(price: menu.price)
            
        }
        .frame(width: 280.0, height: 200.0)
        .padding(10.0)
        
    }
}


struct MenuInHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuTitleView(menu: drinksData[0].menus[0])
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"zh-hans-tw"))
            MenuTitleView(menu: drinksData[0].menus[1])
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"th_th"))
            MenuTitleView(menu: drinksData[0].menus[0])
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"ar-sa"))
                .environment(\.layoutDirection, .rightToLeft)
                
        }
    }
}


