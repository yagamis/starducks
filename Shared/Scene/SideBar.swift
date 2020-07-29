//
//  SliderView.swift
//  starducks
//
//  Created by MAC on 2020/7/20.
//

import SwiftUI

struct SideBar: View {
    @State var collapsed = false
    @Environment(\.layoutDirection) var layout
    
    var body: some View {

        ZStack {
            Color("maskOverlay")
                .offset(x: collapsed ? 0 : -200)
                .opacity(collapsed ? 1 : 0)
                .animation(.easeOut)
                .transition(.opacity)
                .onTapGesture(perform: {
                    collapsed.toggle()
                })
            
            HStack(alignment: .bottom, spacing:-3) {
                LinearGradient(gradient: Gradient(colors: [Color("gradientStart"), Color("gradientEnd")]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 200, height: screen.height)
                
                
                ZStack {
                    Image("green_slide")
                        .renderingMode(.template)
                        .frame(width: 57)
                        .offset(y: -30)
                        .foregroundColor(Color("gradientEnd"))
                        .onTapGesture(perform: {
                            collapsed.toggle()
                        })
                    Image(systemName: "chevron.right").font(.title).foregroundColor(.white)
                        .rotationEffect(collapsed ? .degrees(180) : .zero)
                        .offset(y: 95)
                }
                Spacer()
            }
            .flipsForRightToLeftLayoutDirection(layout == .rightToLeft) //flips the whole view when RTL detected
            .offset(x: collapsed ? 0 : -200)
            .animation(.easeOut)
            .ignoresSafeArea()
            .gesture(
                DragGesture()
                    .onEnded({ (value) in
                        if (abs(value.translation.width) > 10) {
                            withAnimation() {
                                collapsed.toggle()
                            }
                        }
                    })
            )

        }

    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
            .environment(\.locale, .init(identifier:"ar-sa"))
            .environment(\.layoutDirection, .rightToLeft)
    }
}
