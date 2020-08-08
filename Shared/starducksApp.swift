//
//  starducksApp.swift
//  Shared
//
//  Created by MAC on 2020/7/17.
//

import SwiftUI

@main
struct starducksApp: App {

    @StateObject var userStatus = OrderStatus()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(userStatus)
            
        }
    }
}

