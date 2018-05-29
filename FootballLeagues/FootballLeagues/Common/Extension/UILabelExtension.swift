//
//  UILabelExtension.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 4/16/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setLineHeight(lineHeight: CGFloat = 0.0, lineSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString(string: self.text!)
        attrString.addAttribute(NSAttributedStringKey.font, value: self.font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}
