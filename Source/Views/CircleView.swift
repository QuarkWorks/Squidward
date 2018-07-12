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

/// A custom view where the layers corner radius tries to make a circle
@IBDesignable
open class CircleView: UIView {

    open override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
}

/// A custom image view where the layers corner radius tries to make a circle
@IBDesignable
open class CircleImageView: UIImageView {

    open override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
}

open class RoundedView: UIView {

    open var cornerMask: UIRectCorner = [] {
        didSet {
            guard cornerMask != oldValue else { return }
            if !cornerMask.isEmpty {
                layer.masksToBounds = true
            }
            setNeedsLayout()
        }
    }

    open var cornerMaskRadius: CGFloat = 0.0 {
        didSet {
            guard cornerMaskRadius != oldValue else { return }
            if !cornerMask.isEmpty {
                layer.masksToBounds = true
            }
            setNeedsLayout()
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.topLeft, .topRight],
                                 cornerRadii: CGSize(width: cornerMaskRadius,
                                                     height: cornerMaskRadius)).cgPath
        layer.mask = mask
    }
}
