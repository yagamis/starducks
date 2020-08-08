import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    let menu : DrinkMenu
    @State var showMore = false
    @Environment(\.presentationMode) var presentMode
    

    var body: some View {
            ZStack(alignment:.bottom) {
                
                VStack {
                    WebImage(url: URL(string: baseUrl + menu.image[0].url))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 403, height: 516)
                        .padding(.top, 30.0)
                    Spacer()
                }
                
                ZStack(alignment: Alignment.init(horizontal: .leading, vertical: .top)) {
                    Color("maskOverlay")
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical, 55)
                        .padding(.horizontal, 30)
                        .onTapGesture(count: 1, perform: {
                            presentMode.wrappedValue.dismiss()
                        })
                }

                MenuOptionsView(menu: menu, sizeSelection: 0, milkSelection: 0, showMore: $showMore)
                    
                    
               
 
            }.ignoresSafeArea()
        }
}



struct CoffeeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(menu: drinksData[0].menus[0],showMore: false)
                .environment(\.locale, .init(identifier:"zh_cn"))
            DetailView(menu: drinksData[0].menus[1],showMore: true)
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"ar_sa"))
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
