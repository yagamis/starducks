//
//  test111.swift
//  starducks
//
//  Created by MAC on 2020/7/22.
//

import SwiftUI

struct test111: View {
    // What is the current status
    @State var flipped = false
    
    // Whats the initial "flip" degree
    @State var degrees = 180.0
    
    @State var width: CGFloat = 200
    @State var height: CGFloat = 300
    
    var body: some View {
        ZStack {
            if flipped {
                //Cart Back
                CardBack(width: self.$width, height: self.$height)
                  
            } else {
                //Cart front

                CardFront(width: self.$width, height: self.$height)
                 
            }
        }//Styling
        .background(Color.gray)
        .cornerRadius(20)
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
            
            // When tapped turn it around
        .onTapGesture {
            flipped.toggle()
            
            if self.flipped {
                withAnimation {
                    self.degrees += 180
                    self.width = 200 // add other animated stuff here
                    self.height = 300
                }
            } else {
                withAnimation {
                    self.degrees -= 180
                    self.width = 300 // add other animated stuff here
                    self.height = 500
                }
            }
        }
    }
}

struct CardBack: View {
    
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    
    var body: some View {
        Rectangle().foregroundColor(Color.pink).frame(width: self.width, height: self.height).overlay(Text("Back"))
    }
}

struct CardFront: View {
    
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    
    var body: some View {
        Rectangle().foregroundColor(Color.purple).frame(width: self.width, height: self.height).overlay(Text("Front"))
    }
}

struct test111_Previews: PreviewProvider {
    static var previews: some View {
        test111()
    }
}
