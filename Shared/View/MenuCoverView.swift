import SwiftUI
import SDWebImageSwiftUI

struct MenuCoverView: View {
    let coverImage : CoverImage
 
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
                
            WebImage(url: URL(string: baseUrl + coverImage.url))
                .resizable()
                .scaledToFit()
                .frame(width: 230)
        }
    }
}

struct MenuCoverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuCoverView(coverImage: drinksData[0].menus[0].image[0])
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            MenuCoverView(coverImage: drinksData[0].menus[2].image[0])
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            MenuCoverView(coverImage: drinksData[0].menus[1].image[0])
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
