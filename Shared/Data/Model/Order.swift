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

class Store: ObservableObject {
    enum Action: String {
        case start, add, delete, hudEnd, pay
    }

    @Published var action = Action.start
    @Published var unpaidOrders: [Order] = []
    @Published var currentOrder: Order?
    @Published var collapse = false
    @Published var showPay = false

    func getUnpaidOrders() {
        AnyRequest<[Order]> {
            Url(Network.findOrders)
            Query([
                "_sort"  : "created_at:DESC",
                "status" : "0", //unpaid filter
            ])
        }
        .onObject({ (orders) in
            DispatchQueue.main.async {
                self.unpaidOrders = orders
            }
        })
        .call()
    }
    
    
}
