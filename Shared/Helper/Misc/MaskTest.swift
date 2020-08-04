//
//  MaskTest.swift
//  starducks
//
//  Created by MAC on 2020/7/24.
//

import SwiftUI

struct MaskTest: View {
    let colors: [Color] = [.red, .green, .blue]

        var body: some View {
            ScrollView {
                ScrollViewReader { value in
                    Button("Jump to #25") {
                        withAnimation {
                            value.scrollTo(25)
                        }
                       
                    }

                    ForEach(0..<30) { i in
                        Text("Example \(i)")
                            .frame(width: 100, height: 100)
                            .background(colors[i % colors.count])
                            .id(i)
                    }
                }
            }
//            .content.offset(y:0.0)
        }
        
}

struct MaskTest_Previews: PreviewProvider {
    static var previews: some View {
        MaskTest()
            .preferredColorScheme(.dark)
    }
}
