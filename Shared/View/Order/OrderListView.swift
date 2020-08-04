import SwiftUI

struct OrderListView: View {
    var orders : [Order]
    @Binding var selection : Int
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {

            VStack(spacing: 40,  content: {
                Text("最近订单")
                    .font(.system(size: 32))
                if !orders.isEmpty {
                    ForEach(orders.indices, id: \.hashValue) { (index) in
                        LazyVStack {
                            OrderCoverView(imgUrl: orders[index].imgUrl)
                            Text(orders[index].menu_name)
                                .font(.system(size: 24))
                                .frame(maxWidth: 150,maxHeight: .infinity)
                        }
    //                        .onTapGesture {
    //                            withAnimation(Animation.interactiveSpring()) {
    //                                selection = index
    //                            }
    //                        }
                    }
                }
               
            })
            .padding(.top, 40)
            .foregroundColor(.white)
            .frame(width: 160)
        })
    }
}

struct OrderListView_Previews: PreviewProvider {

    struct testView1: View {
        @State private var selection = 0
        
        var body: some View {
            OrderListView(orders: ordersData, selection: $selection)
        }
    }
    
    static var previews: some View {
        testView1()
            .preferredColorScheme(.dark)
    }
}
