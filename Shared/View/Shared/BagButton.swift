import SwiftUI

struct BagButton: View {
    @EnvironmentObject var status : OrderStatus
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            Image("bag")
                .renderingMode(.template)
                .frame(width: 74,height: 74)
                .overlay(
                    RoundedRectangle(cornerRadius: 37)
                        .stroke(lineWidth: 3)
                )
            
            if status.unpayOrders.count > 0 {//数字角标
                ZStack {
                    Circle()
                        .frame(width: 25, height: 25)
                    Text(status.unpayOrders.count < 100 ? "\(status.unpayOrders.count)" : "99+")
                        .foregroundColor(Color(.systemBackground))
                }.offset(x: -8, y: 8)
            }
        }
        //hub结束并不获取新订单
        .onReceive(status.$action, perform: { act in
            print(act)
            if act != .hudEnd {
                status.getUnpayOrders()
            }
        })
    }
}

struct ShoppingBagView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            BagButton()
                .previewLayout(.sizeThatFits)
                .environmentObject(OrderStatus())
            BagButton()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environmentObject(OrderStatus())
        }
    }
}
