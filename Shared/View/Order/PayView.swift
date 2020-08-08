import SwiftUI
import Request

struct PayView: View {
    @State var paySelection : Int

    @State private var loading = false
    @EnvironmentObject var status : OrderStatus
    @Binding var showPay : Bool
    
    var body: some View {

        VStack() {
            Spacer()
            VStack {
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width: 42, height: 6)
                        .opacity(0.15)
                        .padding(.top, 16)
                    
                    // title and price
                    VStack(alignment: .center) {
                        MenuTitle(name: status.currentOrder!.menu_name)
                        PriceLabel(price: status.currentOrder!.price)
                    }
                    .padding()

                        VStack(alignment: .leading) {
                            Text("支付方式")
                                .font(.system(size: 24))
                                .foregroundColor(Color(.secondaryLabel))
                            
                            PayChoiceView(selection: $paySelection)
                            
                        }.padding()
                        .transition(.slide)
                        .animation(.spring())

                    
                    if loading {
                        ProgressView("")
                    }
                    
                    PayButton()
                        .padding()
                        .onTapGesture{
                            updateOrder(id: status.currentOrder!.id)
                        }
                    
                }
                .background(Blur(style: .systemChromeMaterial))
                .cornerRadius(30)
                .shadow(color: .clear, radius: 2, x: 0, y: 1)
        }.frame(height: screen.height / 2 + 90)

    }
    
    func updateOrder(id: Int)  {
        loading = true
        
        var newOrder = status.currentOrder!
        newOrder.status = 1
        newOrder.payvender = paySelection.description
        
        AnyRequest<Order> {
            Url(Network.updateOrder + id.description)
            Method(.put)
            Header.ContentType(.json)
            RequestBody(newOrder)
        }
        .onObject { _ in
            withAnimation {
                loading = false
                status.action = .pay //订单支付的全局通知
                
                showPay.toggle()
            }
        }
        .onError { (error) in
            print("Error update：",error)
            withAnimation {
                loading = false
            }
        }
        .call()
    }
    
}

struct PayView_Previews: PreviewProvider {
    struct testView1: View {
        
        @State var sel1 : Int
        @State var showPay = false
        @StateObject var status : OrderStatus = {
            let _status1 = OrderStatus()
            _status1.currentOrder = ordersData[0]
            return _status1
        }()

        var body: some View {
            PayView(paySelection: sel1, showPay: $showPay)
                .environmentObject(status)
        }
    }
    
    
    static var previews: some View {
        Group {
            testView1(sel1: 1)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"zh_cn"))
            testView1(sel1: 2)
                .environment(\.locale, .init(identifier:"ja_jp"))
        }
    }
}


