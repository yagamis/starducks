import SwiftUI
import Request

struct SideBar: View {
    @State var collapsed = false
    @Environment(\.layoutDirection) var layout
    @State var orders : [Order] = []

    @State private var selection = 0
    
    var body: some View {

        ZStack {
            Color("maskOverlay")
                .offset(x: collapsed ? 0 : -200)
                .opacity(collapsed ? 1 : 0)
                .animation(.easeOut)
                .transition(.opacity)
                .onTapGesture(perform: {
                    collapsed.toggle()
                })
            
            HStack(alignment: .bottom, spacing:-3) {
                ZStack(alignment: .top) { //对齐，防止顶端缝隙
                    LinearGradient(gradient: Gradient(colors: [Color("gradientStart"), Color("gradientEnd")]), startPoint: .leading, endPoint: .trailing)
                        .frame(width: 200, height: screen.height )
                    
                    if !orders.isEmpty && collapsed {
                        OrderListView(orders: $orders, selection: $selection)
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
                            getOrders()
                        })
                    Image(systemName: "chevron.right").font(.title).foregroundColor(.white)
                        .rotationEffect(collapsed ? .degrees(180) : .zero)
                        .offset(y: 95)
                }
                Spacer()
            }
            .flipsForRightToLeftLayoutDirection(layout == .rightToLeft) //flips the whole view when RTL detected
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
                                getOrders()
                            }
                        }
                    })
            )

        }
        .ignoresSafeArea()

    }
    
    func getOrders() {
        AnyRequest<[Order]> {
            Url(Network.findOrders)
            Query([
                "_sort"  : "created_at:DESC",
                "_limit" : "10",
            ])
        }
        .onObject({ (orders) in
            withAnimation {
                self.orders = orders
            }
        })
        .call()
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SideBar()
            SideBar()
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
