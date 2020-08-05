
//import SwiftUI
//import Request
//import Json

let baseUrl = "http://localhost:1337"


struct Network {
    static let findDrinks = baseUrl + "/drinks"
    static let createOrder = baseUrl + "/orders"
    static let findOrders = createOrder
    static let deleteOrder = createOrder + "/"
}
    
//    static func createAnOrder(str: String,
//                   onError: @escaping (RequestError) -> Void ,
//                   onJson: @escaping (Json) -> Void) {
//        Request {
//            Url(createOrder)
//            Method(.post)
//            Header.ContentType(.json)
//            Body(str)
//        }
//
//        .onError { (error) in
//            onError(error)
//        }
//        .onJson { (json) in
//            onJson(json)
//        }
//        .call()
//    }


//        Network.createAnOrder(str: jsonStr) { (error) in
//            print("Error, 添加订单错误：",error)
//            withAnimation {
//                loading = false
//            }
//        } onJson: { (json) in
//            print("返回结果：",json)
//            withAnimation {
//                loading = false
//                complete = true
//                presentMode.wrappedValue.dismiss()
//            }
//        }

