import SwiftUI
import SDWebImageSwiftUI

struct OrderCoverView: View {
    let imgUrl : String
 
    var body: some View {
        ZStack() {
            Group {
                if Bool.random() {
                    Image("coffeeMask")
                        .renderingMode(.template)
                        .resizable()
                } else {
                    RoundedRectangle(cornerRadius: 16)
                }
            }
            .foregroundColor(Color("orderCoverMask"))
            .frame(width: 122, height: 137)
                
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 92)
        }
    }
}

struct OrderCoverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderCoverView(imgUrl: ordersData[0].imgUrl)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            OrderCoverView(imgUrl: ordersData[1].imgUrl)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)

        }
    }
}
