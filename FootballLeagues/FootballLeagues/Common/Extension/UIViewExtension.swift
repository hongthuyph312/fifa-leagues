//
//  UIViewExtension.swift
//  LocationTracking
//
//  Created by Nguyen Hai Dang on 6/19/17.
//  Copyright © 2017 Nguyen Hai Dang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setupBorder() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func customBorder(radius: CGFloat, color: UIColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    func startBlink() {
        UILabel.animate(withDuration: 1.0,
                       delay:0.0,
                       options:[.autoreverse, .repeat],
                       animations: {
                        self.alpha = 0.3
        }, completion: nil)
        //        let myDelay = 0.0
        //        let scalePulseAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        //        scalePulseAnimation.beginTime = CACurrentMediaTime() + myDelay
        //        scalePulseAnimation.duration = 1.5
        //        scalePulseAnimation.repeatCount = .infinity
        //        scalePulseAnimation.autoreverses = true
        //        scalePulseAnimation.fromValue = 1.0
        //        scalePulseAnimation.toValue = 0
        //        self.layer.add(scalePulseAnimation, forKey: "opacity")
    }
    
    func stopBlink() {
        alpha = 1
        layer.removeAllAnimations()
    }
    
    func tappedDismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
        
    }
    
    @objc func dismisskeyboard() {
        self.endEditing(true)
    }
}
