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

public final class LayoutPointAnchors {

    /// The xAsis layout anchor.
    internal let xAxis: NSLayoutXAxisAnchor

    /// The yAsis layout anchor.
    internal let yAxis: NSLayoutYAxisAnchor
    
    internal init(xAxis: NSLayoutXAxisAnchor, yAxis: NSLayoutYAxisAnchor) {
        self.xAxis = xAxis
        self.yAxis = yAxis
    }

    /**
     Constrains to another view's anchors with an offset.
     
     - parameter anchors: The the target anchors to be constrained to.
     - parameter constant: An offset that is applied the both the x and y axis.
     
     - returns: The newly constructed set of deactivated layout center constraints.

    */
    public func constraint(eqaulTo anchors: LayoutPointAnchors, constant: UIOffset = .zero) -> LayoutPointConstraints {
        return LayoutPointConstraints(xAxis: xAxis.constraint(equalTo: anchors.xAxis, constant: constant.horizontal),
                                      yAxis: yAxis.constraint(equalTo: anchors.yAxis, constant: constant.vertical))
    }
}

public extension LayoutGuide {

    /// A group of center layout anchors that can be used to create LayoutCenterConstraints
    public var centerAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: centerXAnchor, yAxis: centerYAnchor)
    }
    
    /*
        Rect Corner Anchors
    */
    
    public var topLeftAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: leftAnchor, yAxis: topAnchor)
    }
    
    public var topRightAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: rightAnchor, yAxis: topAnchor)
    }
    
    public var bottomLeftAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: leftAnchor, yAxis: bottomAnchor)
    }
    
    public var bottomRightAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: rightAnchor, yAxis: bottomAnchor)
    }
    
    /*
     Directional Rect Corner Anchors
    */
    
    public var topLeadingAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: leadingAnchor, yAxis: topAnchor)
    }
    
    public var topTrailingAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: trailingAnchor, yAxis: topAnchor)
    }
    
    public var bottomLeadingAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: leadingAnchor, yAxis: bottomAnchor)
    }
    
    public var bottomTrailingAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: trailingAnchor, yAxis: bottomAnchor)
    }
    
    /*
     Rect Edge Anchors
    */

    public var centerLeftAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: leftAnchor, yAxis: centerYAnchor)
    }
    
    public var centerTopAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: centerXAnchor, yAxis: topAnchor)
    }
    
    public var centerRightAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: rightAnchor, yAxis: centerYAnchor)
    }
    
    public var centerBottomAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: centerXAnchor, yAxis: bottomAnchor)
    }

    /*
     Directional Edge Anchors
    */
    
    public var centerLeadingAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: leadingAnchor, yAxis: centerYAnchor)
    }
    
    public var centerTrailingAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: trailingAnchor, yAxis: centerYAnchor)
    }
}

public final class LayoutPointConstraints {

    /// The x axis constraint
    public let xAxis: NSLayoutConstraint

    /// The y axis constraint
    public let yAxis: NSLayoutConstraint

    internal init(xAxis: NSLayoutConstraint, yAxis: NSLayoutConstraint) {
        self.xAxis = xAxis
        self.yAxis = yAxis
    }

    /// A constant that can be applied the the x and y constraints
    public var constant: UIOffset {
        get {
            return UIOffset(horizontal: xAxis.constant,
                            vertical: yAxis.constant)
        }

        set {
            xAxis.constant = newValue.horizontal
            yAxis.constant = newValue.vertical
        }
    }
}

extension LayoutPointConstraints: LayoutConstraintGroup {

    public var constraints: [NSLayoutConstraint] {
        return [xAxis, yAxis]
    }
}
