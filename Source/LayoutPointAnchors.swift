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

public class LayoutPointAnchors {

    /// The xAsis layout anchor
    public let xAxis: NSLayoutXAxisAnchor

    /// The yAsis layout anchor
    public let yAxis: NSLayoutYAxisAnchor
    
    internal init(xAxis: NSLayoutXAxisAnchor, yAxis: NSLayoutYAxisAnchor) {
        self.xAxis = xAxis
        self.yAxis = yAxis
    }

    /**
     Constrains to another view's anchors with an offset
     
     - parameter anchors: The the target anchors to be constrained to.
     - parameter offset: An offset that is applied the both the x and y axis.
     
     - returns: The newly constructed set of deactivated layout center constraints.

    */
    public func constraint(eqaulTo anchors: LayoutPointAnchors, offset: UIOffset = .zero) -> LayoutPointConstraints {
        return LayoutPointConstraints(xAxis: xAxis.constraint(equalTo: anchors.xAxis, constant: offset.horizontal),
                     yAxis: yAxis.constraint(equalTo: anchors.yAxis, constant: offset.vertical))
    }
}

public extension LayoutGuide {

    /// A group of center layout anchors that can be used to create LayoutCenterConstraints
    public var centerAnchors: LayoutPointAnchors {
        return LayoutPointAnchors(xAxis: centerXAnchor, yAxis: centerYAnchor)
    }

    /**
     Returns point anchors for the center of a specified edge.

     - parameter edge: The edge to dictate what point anchors are returned.
     - returns: The newly constructed layout point anchors.
     */
    public func centerAnchors(for edge: RectEdge) -> LayoutPointAnchors {


        return LayoutPointAnchors(xAxis: edge.xAxisAnchor(for: self),
                                  yAxis: edge.yAxisAnchor(for: self))
    }
    
    /**
     Returns point anchors for the center of a specified directional edge.
     
     - parameter edge: The edge to dictate what point anchors are returned.
     - returns: The newly constructed layout point anchors.
     */
    public func centerAnchors(for edge: DirectionalRectEdge) -> LayoutPointAnchors {
        
        
        return LayoutPointAnchors(xAxis: edge.xAxisAnchor(for: self),
                                  yAxis: edge.yAxisAnchor(for: self))
    }

    /**
     Returns point anchors for the specified corner.

     - parameter corner: The corner to dicate what point anchros are returned.
     - returns: The newly constructed layout point anchors
     */
    public func cornerAnchors(for corner: RectCorner) -> LayoutPointAnchors {

        return LayoutPointAnchors(xAxis: corner.xAxisAnchor(for: self),
                                  yAxis: corner.yAxisAnchor(for: self))
    }
    
    /**
     Returns point anchors for the specified directional corner.
     
     - parameter corner: The corner to dicate what point anchros are returned.
     - returns: The newly constructed layout point anchors
     */
    public func cornerAnchors(for corner: DirectionalRectCorner) -> LayoutPointAnchors {
        
        return LayoutPointAnchors(xAxis: corner.xAxisAnchor(for: self),
                                  yAxis: corner.yAxisAnchor(for: self))
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
            return UIOffset(horizontal: xAxis.constant, vertical: yAxis.constant)
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
