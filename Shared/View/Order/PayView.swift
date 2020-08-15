import SwiftUI
import Request

struct PayView: View {
    @State var paySelection : Int
    
    @State private var loading = false
    @EnvironmentObject var status : OrderStatus
    @Binding var showPay : Bool
    
    
    var body: some View {

            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        .opacity(0.5)
                        .onTapGesture(perform: {
                            withAnimation {
                                showPay.toggle()
                            } 
                        })
                }
                .padding(.top)
                .padding(.trailing)
                
  
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
                        
                        
                        if loading {
                            ProgressView("")
                        }
                        
                        Button(action: {
                            updateOrder(id: status.currentOrder!.id)
                        }, label: {
                            PayButton()
                        }).padding()
                        
                    }
                    .background(Blur(style: .systemChromeMaterial))
                    .cornerRadius(30)
                    .shadow(color: .clear, radius: 2, x: 0, y: 1)
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
                loading = false
                status.collapse = false //关闭侧边栏
                status.action = .pay //订单支付的全局通知
                
                showPay.toggle()
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
            _status1.currentOrder = ordersData[2]
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
                
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"zh_cn"))
            testView1(sel1: 0)
                .environment(\.locale, .init(identifier:"ja_jp"))
        }.previewLayout(.sizeThatFits)
    }
}


