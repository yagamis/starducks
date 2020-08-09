import SwiftUI
import Request

struct MenuOptionsView: View {
    let menu : DrinkMenu
    @State var sizeSelection : Int
    @State var milkSelection : Int
    @Binding var showMore : Bool
    @Environment(\.presentationMode) var presentMode
    
    @State var loading = false
    
    @EnvironmentObject var status : OrderStatus
    
    var body: some View {
        
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 42, height: 6)
                    .opacity(0.15)
                    .padding(.top, 16)
                
                // title and price
                VStack(alignment: .center) {
                    MenuTitle(name: menu.name)
                    if !showMore {
                        PriceLabel(price: menu.price)
                            .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    }
                }
                .padding()
                
                //show options area
                if showMore {
                    VStack(alignment: .leading) {
                        Text("杯型")
                            .font(.system(size: 24))
                            .foregroundColor(Color(.secondaryLabel))
                        
                        SizeOptionsView(selection: $sizeSelection)
                        
                    }.padding()
                    .transition(.slide)
                    .animation(.spring())
                    
                    if !menu.milk.isEmpty {
                        VStack(alignment: .leading) {
                            Text("配奶")
                                .font(.system(size: 24))
                                .foregroundColor(Color(.secondaryLabel))
                            MilkOptionsView(selection: $milkSelection, options: menu.milk)
                            
                        }.padding()
                        .transition(.slide)
                        .animation(.spring())
                    }
                    
                }
                
                if loading {
                    ProgressView("")
                }
                
                AddToBagButton().onTapGesture{
                    createOrder()
                }
                
            }
            .background(Blur(style: .systemChromeMaterial))
            .cornerRadius(30)
            .shadow(color: .clear, radius: 2, x: 0, y: 1)
            .ignoresSafeArea()
        }.ignoresSafeArea()
        .offset(y: -10)
        .gesture(
            DragGesture()
                .onEnded({ (value) in
                    if (abs(value.translation.height) > 10) {
                        withAnimation(Animation.spring()) {
                            showMore.toggle()
                        }
                    }
                })
        )
        
        
    }
    
    func createOrder()  {
        loading = true
        
        var newOrder = Order()
        newOrder.menu_id = menu.id
        newOrder.menu_name = menu.name
        newOrder.size = sizeSelection.description
        newOrder.price = menu.price
        newOrder.quantity = 1
        newOrder.imgUrl = menu.image[0].formats["thumbnail"]!.url
        newOrder.status = 0
        if !menu.milk.isEmpty {
            newOrder.milk_option = menu.milk[milkSelection].name
        }
        
        Request {
            Url(Network.createOrder)
            Method(.post)
            Header.ContentType(.json)
            RequestBody(newOrder)
        }
        .onJson { _ in

                withAnimation {
                    loading = false
                    status.currentOrder = newOrder
                    status.action = .add //订单增加的全局通知
                    
                    
                    presentMode.wrappedValue.dismiss()
                }

        }
        .onError { (error) in
            print("Error create：",error)
            withAnimation {
                loading = false
            }
        }
        .call()
    }
    
}

struct BagOptionView_Previews: PreviewProvider {
    struct testView1: View {
        let menu : DrinkMenu
        
        @State var sel1 : Int
        @State var sel2 : Int
        @State var more : Bool
        
        var body: some View {
            MenuOptionsView(menu: menu, sizeSelection: sel1, milkSelection: sel2, showMore: $more)
        }
    }
    
    
    static var previews: some View {
        Group {
            testView1(menu: drinksData[0].menus[1], sel1: 0, sel2: 0, more: false)
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"zh_cn"))
            testView1(menu: drinksData[0].menus[0], sel1: 0, sel2: 0, more: false)
                
                .environment(\.locale, .init(identifier:"ja_jp"))
            
        }
    }
}


