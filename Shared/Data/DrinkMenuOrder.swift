//
//  Menu.swift
//  starducks
//
//  Created by MAC on 2020/7/18.
//

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
}


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
}
