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

import UIKit

/// The minimum collection of anchors needed to describe a `UILayoutGuide`
public protocol LayoutGuide {

    /// A directional layout anchor representing the leading edge of the layout guide’s frame.
    var leadingAnchor: NSLayoutXAxisAnchor { get }

    /// A directional layout anchor representing the trailing edge of the layout guide’s frame.
    var trailingAnchor: NSLayoutXAxisAnchor { get }

    /// A layout anchor representing the left edge of the layout guide’s frame.
    var leftAnchor: NSLayoutXAxisAnchor { get }

    /// A layout anchor representing the right edge of the layout guide’s frame.
    var rightAnchor: NSLayoutXAxisAnchor { get }

    /// A layout anchor representing the top edge of the layout guide’s frame.
    var topAnchor: NSLayoutYAxisAnchor { get }

    /// A layout anchor representing the bottom edge of the layout guide’s frame.
    var bottomAnchor: NSLayoutYAxisAnchor { get }

    /// A layout anchor representing the width of the layout guide’s frame.
    var widthAnchor: NSLayoutDimension { get }

    /// A layout anchor representing the height of the layout guide’s frame.
    var heightAnchor: NSLayoutDimension { get }

    /// A layout anchor representing the horizontal center of the layout guide’s frame.
    var centerXAnchor: NSLayoutXAxisAnchor { get }

    /// A layout anchor representing the vertical center of the layout guide’s frame.
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutGuide { }

extension UILayoutGuide: LayoutGuide { }

extension UIView {

    /// A nil returning wrapper around `safeAreaLayoutGuide` for non iOS 11 builds
    public var safeAreaLayoutGuideOrNil: LayoutGuide? {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        } else {
            return nil
        }
    }

    public var safeAreaInstetsOrNil: UIEdgeInsets? {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        } else {
            return nil
        }
    }
}
