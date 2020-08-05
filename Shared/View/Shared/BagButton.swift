import SwiftUI

struct BagButton: View {
    @State var unpay = 0
    @State var paidSum = 0
    
    var body: some View {
        
            HStack {
                if paidSum != 0 {
                        OrderThumbView(imgUrl: ordersData[1].imgUrl)
                        Text("已下单，派送中!")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                }

                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    Image("bag")
                        .renderingMode(.template)
                        .frame(width: 74,height: 74)
                        .if(paidSum == 0) { //如果未支付，显示圆圈边框
                            $0.overlay(
                                RoundedRectangle(cornerRadius: 37)
                                    .stroke(lineWidth: 3)
                            )
                        }
                        
                        
                        
                    if unpay > 0 {
                        ZStack {
                            Circle()
                                .frame(width: 25, height: 25)
                            Text("\(unpay)")
                                .foregroundColor(.white)
                        }.offset(x: -8, y: 8)
                    }
                }
            }
            .padding(5)
            .if(paidSum != 0) { //如果有支付，则显示带阴影的圆角矩形边框
                $0.background(
                    RoundedRectangle(cornerRadius: 56)
                        .foregroundColor(Color(.tertiarySystemBackground))
                        .shadow(color: Color("AccentColor"), radius: 5)
                        .padding(.vertical, 15)
                )
            }

    }
}

struct ShoppingBagView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            BagButton(unpay: 3,paidSum: 1)
                .previewLayout(.sizeThatFits)
            BagButton(unpay: 3)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
