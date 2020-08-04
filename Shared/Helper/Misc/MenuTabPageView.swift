//
//  MenuCoverListView.swift
//  starducks
//
//  Created by MAC on 2020/7/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct MenuTabPageView: View {
    let menus : [DrinkMenu]
    
    @State private var index = 0
    
    var body: some View {
        
        TabView(selection: $index)  {
            ForEach(menus.indices) { (index)  in              
                ZStack {
                    Image("coffeeMask1")
                    WebImage(url: URL(string: baseUrl + menus[index].image[0].url))
                        .resizable()
                        .scaledToFit()
                }.tag(index)
                .frame(width: 230, height: self.index == index ? 404 : 300)
//                .tabItem {
//                    WebImage(url: URL(string: baseUrl + menus[index].image[0].url))
//                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        
        .animation(.easeOut)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

    }
}

struct MenuTabPageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuTabPageView(menus: drinksData[0].menus)
        }
            
    }
}
