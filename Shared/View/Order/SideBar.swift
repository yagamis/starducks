import SwiftUI
import Request

struct SideBar: View {
    @State var collapsed = false
    @Environment(\.layoutDirection) var layout
    @EnvironmentObject var store : Store
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
                    
                    if !store.unpaidOrders.isEmpty && collapsed {
                        OrderListView(orders: $store.unpaidOrders, selection: $selection, showPay: $store.showPay)
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
                            store.getUnpaidOrders()
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
                                store.getUnpaidOrders()
                            }
                        }
                    })
            )

            
            //支付view
            if store.showPay {
                Group {
                    Color("maskOverlay")
                        .onTapGesture {
                            withAnimation {
                                store.showPay.toggle()
                            }
                    }
                    VStack {
                        Spacer()
                        PayView(paySelection: 0, showPay: $store.showPay)
                    }.padding(.bottom, 20)
                }
                .transition(bottomUpTransition)
                .animation(.spring())
            }

        }
        .ignoresSafeArea()
        .onReceive(store.$collapse) {    //收到全局展开指令
            if $0 { //展开，获取订单
                collapsed = true

                store.getUnpaidOrders()
            } else {//关闭
                collapsed = false
            }
        }

    }
    
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           SideBar(collapsed: true)
           SideBar()
                .environment(\.layoutDirection, .rightToLeft)
               
        }
        .environmentObject(Store())
    }
}
