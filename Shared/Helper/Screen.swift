//
//  Screen.swift
//  starducks
//
//  Created by MAC on 2020/7/26.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

    

