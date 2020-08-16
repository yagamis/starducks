import SwiftUI
import Request

struct PayView: View {
    @State var paySelection : Int
    
    @State private var loading = false
    @EnvironmentObject var status : OrderStatus
    @Binding var showPay : Bool
    @State var successPay = false
    
    //for success animation control
    @State private var isSpinning = false
    @State private var isImgShowing = true
    
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
            

            if !successPay {
                Button(action: {
                    updateOrder(id: status.currentOrder!.id)
                }, label: {
                    PayButton()
                }).padding()
            } else {
                ZStack {
                    Image(systemName: "creditcard.fill")
                        .transition(.slide)
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                        .rotationEffect(.degrees(isSpinning ? 360 : 0))
                        .opacity(isImgShowing ? 1 : 0)
                        .animation(.easeInOut(duration: 2))
                        .onAppear {
                            isSpinning.toggle()
                            isImgShowing.toggle()
                        }

                    Image(systemName: "checkmark.circle.fill")
                        .transition(.slide)
                        .font(.system(size: 50))
                        .foregroundColor(.green)
                        .opacity(isImgShowing ? 0 : 1)
                        .rotationEffect(.degrees(isSpinning ? 0 : -60))
                        .animation(Animation.interpolatingSpring(stiffness: 130, damping: 5).delay(1.2))
                }.padding()
            }
            
            
            
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
        .onObject { _ in //成功支付
            DispatchQueue.main.async{
                loading.toggle()
                successPay.toggle()
            }
            
            //等成功支付的2.2秒动画完毕后再更新状态
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                status.action = .pay //订单支付的全局通知
                status.collapse = false //关闭侧边栏
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


