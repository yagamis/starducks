//
//  test666.swift
//  starducks
//
//  Created by MAC on 2020/8/9.
//

import SwiftUI

struct test666: View {
    @State private var bottomSheetShown = false

       var body: some View {
           GeometryReader { geometry in
               Color.green
               BottomSheetView(
                   isOpen: self.$bottomSheetShown,
                   maxHeight: geometry.size.height * 0.7
               ) {
                   Color.purple
               }
           }.edgesIgnoringSafeArea(.all)
       }
   
}

struct test666_Previews: PreviewProvider {
    static var previews: some View {
        test666()
    }
}
