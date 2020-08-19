import SwiftUI
import Request

struct HomeView: View {
    @State var drinks : [Drink] = []

    @State private var loading = false
    @State var drinkSelect = 0
    @State var menuSelects: [Int] = []
    @State var showDetail = false
    @EnvironmentObject  var status : OrderStatus
 
    var body: some View {
        //侧边栏和按钮，悬浮在首页垂直方向下方
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            VStack {
                HStack {
                    Text("饮品")
                        .font(.system(size: 32))
                        .foregroundColor(.accentColor)
                    if drinks.isEmpty && loading {
                        LoadingView()
                    }
                }
                
                if !drinks.isEmpty {
                    DrinkListView(drinks: drinks, selection: $drinkSelect)

                    ForEach(drinks.indices) { (index) in
                        
                        if drinkSelect == index {
                                Group {
                                    MenuListView(menus: drinks[index].menus, selection: $menuSelects[index])
                                    MenuTitleView(menu: drinks[index].menus[menuSelects[index]])
                                }
                                .onTapGesture {
                                    withAnimation {
                                        showDetail.toggle()
                                    }
                                }
                        }
                    }
                }
            }
            .padding(.vertical, 40.0)
            .padding(.leading, 10)
            
            if showDetail {
                DetailView(menu: drinks[drinkSelect].menus[menuSelects[drinkSelect]], showMore: false, showDetail: $showDetail).zIndex(3)
                    
            }
            
            SideBar()
                    .offset(x: drinks.isEmpty ? -100 : 0)
                .zIndex(2)
            
            switch status.action {
            case .add:
                OrderHUD(text: "已下单，等待支付")
                .padding(.bottom,30)
                .padding(.trailing,30)
            case .pay:
                OrderHUD(text:"已支付,配送中！")
                .padding(.bottom,30)
                .padding(.trailing,30)
                
            default:
                BagButton()
                    .foregroundColor(.accentColor)
                    .padding(.bottom,50)
                    .padding(.trailing,30)
                    .offset(x: drinks.isEmpty ? 300 : 0)
                    .onTapGesture {
                        status.collapse.toggle()
                    }
            }
        }
        .onAppear {
            getDataFromNetwork()
//            getDataFromLocal()
        }
        
    }
    
    
    func getDataFromLocal()  {
        loading = true
        
        let drinks:[Drink] = load("drinks.json")
        
        withAnimation {
            //保存每个类别下，菜单的序号
            self.menuSelects = Array(repeating: 0, count: drinks.count)
            self.drinks = drinks
            loading = false
        }
    }
    
    func getDataFromNetwork()  {
        loading = true
        AnyRequest<[Drink]> {
            Url(Network.findDrinks)
        }
        .onObject({ (drinks) in
            withAnimation {
                //保存每个类别下，菜单的序号
                self.menuSelects = Array(repeating: 0, count: drinks.count)
                
                self.drinks = drinks
                
                loading = false
            }
        })
        .call()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"zh_cn"))
                .environmentObject(OrderStatus())
//            HomeView()
//                .previewLayout(.sizeThatFits)
//                .environment(\.locale, .init(identifier:"zh_tw"))
//            HomeView()
//                .previewLayout(.sizeThatFits)
//                .environment(\.locale, .init(identifier:"th_th"))
//            HomeView()
//                .previewLayout(.sizeThatFits)
//                .environment(\.locale, .init(identifier:"ja_JP"))
            HomeView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"ar-sa"))
                .environment(\.layoutDirection, .rightToLeft)
                .environmentObject(OrderStatus())
//            HomeView()
//                .previewLayout(.sizeThatFits)
//                .environment(\.locale, .init(identifier:"ko_kr"))
            
        }
    }
}
