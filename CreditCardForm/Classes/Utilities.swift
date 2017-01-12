//
//  Utilities.swift
//  CreditCardForm
//
//  Created by Atakishiyev Orazdurdy on 11/29/16.
//  Copyright © 2016 Veriloft. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexStr ( hexStr : NSString, alpha : CGFloat) -> UIColor {
        let hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string", terminator: "")
            return UIColor.white;
        }
    }
}

extension Bundle {
    /// Create a new Bundle instance for 'Image.xcassets'.
    ///
    /// - Returns: a new bundle which contains 'Image.xcassets'.
    static func currentBundle() -> Bundle {
        let bundle = Bundle(for: CreditCardFormView.self)
        if let path = bundle.path(forResource: "CreditCardForm", ofType: "bundle") {
            return Bundle(path: path)!
        } else {
            return bundle
        }
    }
}
