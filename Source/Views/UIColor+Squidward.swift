//
//  UIColor+Squidward.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 5/16/18.
//  Copyright © 2018 QuarkWorks. All rights reserved.
//

import Foundation

extension UIColor {

    public convenience init(red: UInt, green: UInt, blue: UInt, alpha: UInt = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }

    convenience init(hex: UInt) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF)
    }

    convenience init?(hex: String) {
        var string = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }

        guard string.count == 6 else {
            return nil
        }

        var rgbValue: UInt32 = 0
        guard Scanner(string: string).scanHexInt32(&rgbValue) else {
            return nil
        }

        self.init(hex: UInt(rgbValue))
    }
}
