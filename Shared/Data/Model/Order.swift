//
//  Order.swift
//  starducks
//
//  Created by MAC on 2020/8/4.
//

import Foundation

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
