//
//  starducksApp.swift
//  Shared
//
//  Created by MAC on 2020/7/17.
//

import SwiftUI

@main
struct starducksApp: App {

    @StateObject var store = Store()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(store)

        }
    }
}

