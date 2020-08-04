//
//  transitionExtension.swift
//  starducks
//
//  Created by MAC on 2020/7/22.
//

import SwiftUI


extension AnyTransition {
    static var rotate: AnyTransition { get {
        AnyTransition.modifier(active: RotateTransition(percent: 0), identity: RotateTransition(percent: 1))
        }
    }
}


struct RotateTransition: GeometryEffect {
    var percent: Double
    
    var animatableData: Double {
        get { percent }
        set { percent = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {

        let rotationPercent = percent
        let a = CGFloat(Angle(degrees: 170 * (1-rotationPercent)).radians)
        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform1 = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        let affineTransform2 = ProjectionTransform(CGAffineTransform(scaleX: CGFloat(percent * 2), y: CGFloat(percent * 2)))
        
        if percent <= 0.5 {
            return ProjectionTransform(transform3d).concatenating(affineTransform2).concatenating(affineTransform1)
        } else {
            return ProjectionTransform(transform3d).concatenating(affineTransform1)
        }
    }
}
