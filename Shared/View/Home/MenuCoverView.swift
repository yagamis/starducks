import SwiftUI
import SDWebImageSwiftUI

struct MenuCoverView: View {
    let imgUrl : String
    @EnvironmentObject var status: OrderStatus
 
    var body: some View {
        ZStack {
            if Bool.random() {
                Image("coffeeMask")
                    .renderingMode(.template)
                    .foregroundColor(Color("coverMask"))
                    
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 270, height: 340)
                    .foregroundColor(Color("coverMask"))
            }
                
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 230)
                .matchedGeometryEffect(id: "ID1", in: status.namespace1)
        }
    }
}

struct MenuCoverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuCoverView(imgUrl: drinksData[0].menus[0].image[0].url)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            MenuCoverView(imgUrl: drinksData[0].menus[2].image[0].url)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            MenuCoverView(imgUrl: drinksData[0].menus[1].image[0].url)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
