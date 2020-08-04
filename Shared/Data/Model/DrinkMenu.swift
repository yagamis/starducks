import Foundation


struct DrinkMenu: Codable,Identifiable {
    var id = 0
    var name = ""
    var desc = ""
    var price = 0.0
    var drink = 0
    var milk : [MilkOption] = []
    var image : [CoverImage] = []
    
}

struct MilkOption: Codable,Identifiable {
    var id = 0
    var name = ""
}


struct CoverImage: Codable,Identifiable {
    var id = 0
    var url = ""
    var formats : [String : imgDetail]
}

struct imgDetail: Codable {
    var url = ""
}
