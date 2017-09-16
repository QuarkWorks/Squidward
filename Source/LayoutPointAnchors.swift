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

    /// Enum for specifying a single rect corner
    public enum RectEdge {
        case top, left, bottom, right

        func xAxisAnchor(for view: UIView) -> NSLayoutXAxisAnchor {
            switch self {
            case .top, .bottom:
                return view.centerXAnchor
            case .left:
                return view.leftAnchor
            case .right:
                return view.rightAnchor
            }
        }

        func yAxisAnchor(for view: UIView) -> NSLayoutYAxisAnchor {
            switch self {
            case .left, .right:
                return view.centerYAnchor
            case .top:
                return view.topAnchor
            case .bottom:
                return view.bottomAnchor
            }
        }
    }

    /// Enum for specifying a single rect edge
    public enum RectCorner {
        case topLeft, topRight, bottomLeft, bottomRight

        func xAxisAnchor(for view: UIView) -> NSLayoutXAxisAnchor {
            switch self {
            case .topLeft, .bottomLeft:
                return view.leftAnchor
            case .topRight, .bottomRight:
                return view.rightAnchor
            }
        }

        func yAxisAnchor(for view: UIView) -> NSLayoutYAxisAnchor {
            switch self {
            case .topLeft, .topRight:
                return view.topAnchor
            case .bottomLeft, .bottomRight:
                return view.bottomAnchor
            }
        }
    }

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
        return .init(xAxis: xAxis.constraint(equalTo: anchors.xAxis, constant: offset.horizontal),
                     yAxis: yAxis.constraint(equalTo: anchors.yAxis, constant: offset.vertical))
    }
}

public extension UIView {

    /// A group of center layout anchors that can be used to create LayoutCenterConstraints
    public var centerAnchors: LayoutPointAnchors {
        return .init(xAxis: centerXAnchor, yAxis: centerYAnchor)
    }

    /**
     Returns point anchors for the center of a specified edge.

     - parameter edge: The edge to dictate what point anchors are returned.
     - returns: The newly constructed layout point anchors.
     */
    public func centerAnchors(for edge: LayoutPointAnchors.RectEdge) -> LayoutPointAnchors {


        return LayoutPointAnchors(xAxis: edge.xAxisAnchor(for: self),
                                  yAxis: edge.yAxisAnchor(for: self))
    }

    /**
     Returns point anchors for the specified corner.

     - parameter corner: The corner to dicate what point anchros are returned.
     - returns: The newly constructed layout point anchors
     */
    public func cornerAnchors(for corner: LayoutPointAnchors.RectCorner) -> LayoutPointAnchors {

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
            return .init(horizontal: xAxis.constant, vertical: yAxis.constant)
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
