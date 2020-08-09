import SwiftUI

struct OrderHUD: View {
    
    @State var text = ""
    @EnvironmentObject var status : OrderStatus
    
    
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
    struct testView: View {
        @State var text = ""
        @StateObject var status : OrderStatus = {
            let _status1 = OrderStatus()
            _status1.currentOrder = ordersData[0]
            return _status1
        }()
        
        var body: some View {
            OrderHUD(text: text)
                .previewLayout(.sizeThatFits)
                .environmentObject(status)
        }
    }

    static var previews: some View {
        Group {
            testView(text: "已下单，等待支付")
                .previewLayout(.sizeThatFits)
            testView(text: "已支付，等待配送")
                .preferredColorScheme(.dark)
        }.previewLayout(.sizeThatFits)
    }
}
