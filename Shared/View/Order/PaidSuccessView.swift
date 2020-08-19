//
//  PayingAnimation.swift
//  starducks (iOS)
//
//  Created by MAC on 2020/8/20.
//

import SwiftUI

struct PaidSuccessView: View {
    
    @State var rotateBlueCircle = false
    @State var scaleUpGreenCircle = false
    @State var showCheckMark = false
    let loadingDur = 2.0
    let checkDur = 0.3
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 1/20, to: 1)
                .stroke(Color.blue, lineWidth: 4)
                .frame(width: 50,height:50)
                .rotationEffect(.degrees(rotateBlueCircle ? 0 : -1440))
                .animation(.easeIn(duration: loadingDur))
                .onAppear {
                    rotateBlueCircle.toggle()
            }
            Circle()
                .frame(width: 54,height:54)
                .foregroundColor(.green)
                .scaleEffect(scaleUpGreenCircle ? 1 : 0)
                .animation(.easeOut(duration: loadingDur))
                .onAppear() {
                    scaleUpGreenCircle.toggle()
                }
            
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .scaleEffect(showCheckMark ? 1 : 0)
                .font(.system(size: 30))
                .animation(Animation.easeOut(duration: checkDur).delay(loadingDur - checkDur))
                .onAppear() {
                    showCheckMark.toggle()
                }
        }.padding()
        
        
    }
}

struct PayingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        PaidSuccessView()
    }
}
