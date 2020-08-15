import SwiftUI
import Request

struct SideBar: View {
    @State var collapsed = false
    @Environment(\.layoutDirection) var layout
    @EnvironmentObject var status : OrderStatus
    @State private var selection = 0

    var body: some View {

        ZStack {
            //遮罩
            Color("maskOverlay")
                .offset(x: collapsed ? 0 : -200)
                .opacity(collapsed ? 1 : 0)
                .animation(.easeOut)
                .transition(.opacity)
                .onTapGesture(perform: {
                    collapsed.toggle()
                })

            
            //订单侧边栏
            HStack(alignment: .bottom, spacing:-3) {
                ZStack(alignment: .top) { //对齐，防止顶端缝隙
                    LinearGradient(gradient: Gradient(colors: [Color("gradientStart"), Color("gradientEnd")]), startPoint: .leading, endPoint: .trailing)
                        .frame(width: 200, height: screen.height )
                        .flipsForRightToLeftLayoutDirection(layout == .rightToLeft) //flips the whole view when RTL detected
                    
                    if !status.unpayOrders.isEmpty && collapsed {
                        OrderListView(orders: $status.unpayOrders, selection: $selection, showPay: $status.showPay)
                    }
                }

                ZStack {
                    Image("green_slide")
                        .renderingMode(.template)
                        .frame(width: 57)
                        .offset(y: -30)
                        .foregroundColor(Color("gradientEnd"))
                        .onTapGesture(perform: {
                            collapsed.toggle()
                            if !collapsed {return}
                            status.getUnpayOrders()
                        })
                    Image(systemName: "chevron.right").font(.title).foregroundColor(.white)
                        .rotationEffect(collapsed ? .degrees(180) : .zero)
                        .offset(y: 95)
                }
                .flipsForRightToLeftLayoutDirection(layout == .rightToLeft) //flips the whole view when RTL detected
                
                Spacer()
            }
            
            .offset(x: collapsed ? 0 : -200)
            .animation(.easeOut)
            .ignoresSafeArea()
            .gesture(
                DragGesture()
                    .onEnded({ (value) in
                        if (abs(value.translation.width) > 10) {
                            withAnimation() {
                                collapsed.toggle()
                                if !collapsed {return}
                                status.getUnpayOrders()
                            }
                        }
                    })
            )

            
            //支付view
            if status.showPay {
                Group {
                    Color("maskOverlay")
                        .onTapGesture {
                            withAnimation {
                                status.showPay.toggle()
                            }
                    }
                    VStack {
                        Spacer()
                        PayView(paySelection: 0, showPay: $status.showPay)
                    }.padding(.bottom, 20)
                }
                .transition(bottomUpTransition)
                .animation(.spring())
            }

        }
        .ignoresSafeArea()
        .onReceive(status.$collapse, perform: { col in   //收到全局展开指令
            if col { //展开，获取订单
                collapsed = true

                status.getUnpayOrders()
            } else {//关闭
                collapsed = false
            }
        })

    }
    
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           SideBar(collapsed: true)
           SideBar()
                .environment(\.layoutDirection, .rightToLeft)
               
        }
        .environmentObject(OrderStatus())
    }
}
