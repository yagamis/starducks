import SwiftUI
import Request

struct Order: Codable, Identifiable {
    var id = 0
    var menu_id = 0
    var menu_name = ""
    var milk_option  = ""
    var size = ""
    var price = 0.0
    var quantity = 0
    var imgUrl = ""
    var status = 0
    var payvender = ""
}



class OrderStatus: ObservableObject {
    
    enum Action: String {
        case start, add, delete, hudEnd, pay
    }
    
    
    @Published var action = Action.start
    @Published var unpayOrders: [Order] = []
    @Published var currentOrder: Order?
    @Published var collapse = false
    
    
    func getUnpayOrders() {
        AnyRequest<[Order]> {
            Url(Network.findOrders)
            Query([
                "_sort"  : "created_at:DESC",
                "status" : "0", //unpay filter
            ])
        }
        .onObject({ (orders) in
            withAnimation {
                self.unpayOrders = orders
            }
        })
        .call()
    }
}
