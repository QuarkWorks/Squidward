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

public class LayoutSizeDimensions {

    /// The width constraint.
    public let width: NSLayoutDimension

    /// The height constraint.
    public let height: NSLayoutDimension
    
    internal init(width: NSLayoutDimension, height: NSLayoutDimension) {
        self.width = width
        self.height = height
    }

    /**
     Constrains both width and height to a specific size.

     - parameter constant: The constant that should be constrained.

     - returns: The newly constructed set of deactivated layout edge constraints.
     */
    public func constraint(equalToConstant constant: CGSize) -> LayoutSizeConstraints {
        return LayoutSizeConstraints(
            width: width.constraint(equalToConstant: constant.width),
            height: height.constraint(equalToConstant: constant.height))
    }

    /**
     Constrains to another views anchors with a multiplier and a constant.

     - parameter anchor: The the target anchor that both width and height will be constrained to
     - parameter multiplier: The multiplier that the width and height will be scaled to.
     - parameter constant: The constant that should be constrained.

     - returns: The newly constructed set of deactivated layout size constraints.
     */
    public func constraint(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1.0,
                           offset: UIOffset = .zero) -> LayoutSizeConstraints {
        return LayoutSizeConstraints(
            width: width.constraint(equalTo: anchor, multiplier: multiplier, constant: offset.horizontal),
            height: height.constraint(equalTo: anchor, multiplier: multiplier, constant: offset.vertical))
    }

    /**
     Constrains to another views anchors with a multiplier and a constant.

     - parameter anchors: The the target anchors to be constrained to.
     - parameter multiplier: The multiplier that is applied to the width and height.
     - parameter constant: The constant that should be constrained.

     - returns: The newly constructed set of deactivated layout size constraints.
     */
    public func constraint(equalTo anchors: LayoutSizeDimensions, multiplier: CGFloat = 1.0,
                           offset: UIOffset = .zero) -> LayoutSizeConstraints {
        return LayoutSizeConstraints(
            width: width.constraint(equalTo: anchors.width, multiplier: multiplier, constant: offset.horizontal),
            height: height.constraint(equalTo: anchors.height, multiplier: multiplier, constant: offset.vertical))
    }
}

public extension UIView {

    /// A group of size layout dimensions that can be used to create LayoutSizeConstraints
    public var sizeAnchors: LayoutSizeDimensions {
        return .init(width: widthAnchor, height: heightAnchor)
    }
}

public class LayoutSizeConstraints {

    /// The width constraint
    public let width: NSLayoutConstraint

    /// The height constraint
    public let height: NSLayoutConstraint

    internal init(width: NSLayoutConstraint, height: NSLayoutConstraint) {
        self.width = width
        self.height = height
    }

    /// The constant that is added to both the width and height constraints
    public var constant: CGSize {
        get {
            return CGSize(width: width.constant, height: height.constant)
        }

        set {
            width.constant = constant.width
            height.constant = constant.height
        }
    }
}

extension LayoutSizeConstraints: LayoutConstraintGroup {

    public var constraints: [NSLayoutConstraint] {
        return [width, height]
    }
}

