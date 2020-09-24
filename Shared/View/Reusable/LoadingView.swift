//
//  LoadingView.swift
//  starducks (iOS)
//
//  Created by MAC on 2020/8/20.
//

import SwiftUI

struct LoadingView: View {
    
    @State var rotateBlueCircle = false
    let loadingDur = 1.0

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 1/10, to: 1)
                .stroke(Color.blue, lineWidth: 4)
                .frame(width: 30,height: 30)
                .rotationEffect(.degrees(rotateBlueCircle ? 0 : -360))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false).speed(3))
                .onAppear {
                    rotateBlueCircle.toggle()
            }

        }.padding()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
