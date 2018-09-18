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

    public convenience init(hex: UInt) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF)
    }

    public convenience init?(hex: String) {
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

    public func desaturated(amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        var saturation: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        saturation -= amount
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)

    }
    public func reducedAlpha(amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        var saturation: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        alpha -= amount
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)

    }
}
