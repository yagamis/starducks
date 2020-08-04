//
//  Drink.swift
//  starducks
//
//  Created by MAC on 2020/7/17.
//

import Foundation


struct Drink: Codable,Identifiable {
    var id = 0
    var name = ""
    var menus : [DrinkMenu] = []
    
}
