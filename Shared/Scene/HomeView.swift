import SwiftUI
import Request

struct HomeView: View {
    @State var drinks : [Drink] = []

    @State private var loading = false
    @State var drinkSelection = 0
    @State var menuSelections: [Int] = []
    @State var isShowDetail = false
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
                        ProgressView("")
                    }
                }
                
                if !drinks.isEmpty {
                    DrinkListView(drinks: drinks, selection: $drinkSelection)

                    ForEach(drinks.indices) { (index) in
                        
                        if drinkSelection == index {
                                Group {
                                    MenuListView(menus: drinks[index].menus, selection: $menuSelections[index])
                                    MenuTitleView(menu: drinks[index].menus[menuSelections[index]])
                                }
                                .onTapGesture {
                                    isShowDetail.toggle()
                                }
                                .fullScreenCover(isPresented: $isShowDetail) {
                                    //弹出一个新view，环境变量需要传递
                                    DetailView(menu: drinks[index].menus[menuSelections[index]], showMore: false).environmentObject(status)
                                }
                        }
                    }
                }
            }
            .padding(.vertical, 40.0)
            .padding(.leading, 10)
            
            SideBar()
                    .offset(x: drinks.isEmpty ? -100 : 0)
                .zIndex(1)
            
            switch status.action {
            case .add:
                OrderHUD(text: "已下单，等待支付")
                .padding(.bottom,30)
                .padding(.trailing,30)
            case .pay:
                OrderHUD(text:"已支付,配送中！")
                .padding(.bottom,30)
                .padding(.trailing,30)
                
            case .start, .delete, .hudEnd:
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
            self.menuSelections = Array(repeating: 0, count: drinks.count)
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
                self.menuSelections = Array(repeating: 0, count: drinks.count)
                
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
