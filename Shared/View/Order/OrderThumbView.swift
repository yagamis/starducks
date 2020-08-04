import SwiftUI
import SDWebImageSwiftUI

let r : CGFloat = 34.0

struct HalfCapsule: Shape {
    func path(in rect: CGRect) -> Path {
      
        let leftMiddle = CGPoint(x: 0, y: rect.midY)
        let rightMiddle = CGPoint(x: rect.maxX, y: rect.midY)
        let rightCorner = CGPoint(x: rect.maxX, y: 0)
        let center = CGPoint(x: rect.midX, y: rect.midY)

        return Path {
            $0.move(to: leftMiddle)
            $0.addLine(to: .zero)
            $0.addLine(to: rightCorner)
            $0.addLine(to: rightMiddle)
            
            
            
            $0.addArc(center: center, radius: r, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: true)
        }
    }
}


struct OrderThumbView: View {
    let imgUrl : String
    
    var body: some View {
        ZStack() {
            Circle()
                .frame(width: 2 * r)
                
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 1.5 * r)
        }
        .frame(width: 2 * r, height: 3 * r)
        .clipShape(HalfCapsule())
        
    }
}

struct OrderThumbView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderThumbView(imgUrl: ordersData[0].imgUrl)
                .previewLayout(.sizeThatFits)
            OrderThumbView(imgUrl: ordersData[1].imgUrl)
                .previewLayout(.sizeThatFits)
            OrderThumbView(imgUrl: ordersData[2].imgUrl)
                .previewLayout(.sizeThatFits)
        }
    }
}
