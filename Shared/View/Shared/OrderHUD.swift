import SwiftUI

struct OrderHUD: View {
    @EnvironmentObject var status : OrderStatus
    @State var text = ""
    
    
    var transition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    var body: some View {
        
        HStack {
            OrderThumbView(imgUrl: status.currentOrder?.imgUrl ?? "")
            Text(text)
                .font(.system(size: 22))
                .fontWeight(.semibold)
            
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                
                Image("bag")//购物袋
                    .renderingMode(.template)
                    .frame(width: 74,height: 74)
                
                if status.unpayOrders.count > 0 {
                    ZStack {//数字角标，未支付数目
                        Circle()
                            .frame(width: 25, height: 25)
                        Text(status.unpayOrders.count < 100 ? "\(status.unpayOrders.count)" : "99+")
                            .foregroundColor(Color(.systemBackground))
                    }.offset(x: -8, y: 8)
                }
            }
        }
        .foregroundColor(Color("AccentColor"))
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 56)
                .foregroundColor(Color(.tertiarySystemBackground))
                .shadow(color: Color("AccentColor"), radius: 5)
                .padding(.vertical, 15)
        )//圆角矩形边框、系统背景色，带阴影（辉光）的背景，垂直方向填充
        .onAppear {//指定时间内自动消失
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    status.action = .hudEnd
                }
            }
            
        }
        
        .transition(transition)
        
    }
}

struct OrderHUD_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            OrderHUD(text: "已下单，等待支付")
                .previewLayout(.sizeThatFits)
                .environmentObject(OrderStatus())
            OrderHUD(text: "已支付，等待配送")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environmentObject(OrderStatus())
        }
    }
}
