//
//  Squidward
//
//  Copyright (c) 2017 - Present QuarkWorks - https://github.com/quarkworks
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
