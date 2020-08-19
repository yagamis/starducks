//
//  addSuccessView.swift
//  starducks (iOS)
//
//  Created by MAC on 2020/8/20.
//

import SwiftUI

struct addSuccessView: View {
    @State private var isSpinning = false
    @State private var isImgShowing = true
    
    var body: some View {
        ZStack {
            Image(systemName: "creditcard.fill")
                .transition(.slide)
                .font(.system(size: 50))
                .foregroundColor(.red)
                .rotationEffect(.degrees(isSpinning ? 360 : 0))
                .opacity(isImgShowing ? 1 : 0)
                .animation(.easeInOut(duration: 2))
                .onAppear {
                    isSpinning.toggle()
                    isImgShowing.toggle()
                }

            Image(systemName: "checkmark.circle.fill")
                .transition(.slide)
                .font(.system(size: 50))
                .foregroundColor(.green)
                .opacity(isImgShowing ? 0 : 1)
                .rotationEffect(.degrees(isSpinning ? 0 : -60))
                .animation(Animation.interpolatingSpring(stiffness: 130, damping: 5).delay(1.2))
        }.padding()
    }
}

struct addSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        addSuccessView()
    }
}
