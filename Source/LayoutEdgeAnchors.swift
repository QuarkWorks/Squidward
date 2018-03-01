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

public class LayoutEdgeAnchors {

    /// The top anchor.
    internal let top: NSLayoutYAxisAnchor

    /// The left anchor.
    internal let left: NSLayoutXAxisAnchor

    /// The bottom anchor.
    internal let bottom: NSLayoutYAxisAnchor

    /// The right anchor
    internal let right: NSLayoutXAxisAnchor
    
    internal init(top: NSLayoutYAxisAnchor, left: NSLayoutXAxisAnchor,
                bottom: NSLayoutYAxisAnchor, right: NSLayoutXAxisAnchor) {
        
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }

    /**
     Constrains a list of provided edges to another view's anchors with insets.
     At least one edge must be constrained.

     - parameter edges: The edges that should be constrained.
     - parameter anchors: The the target anchors to be constrained to.
     - parameter constant: Insets that is applied to all the provided edges.

     - returns: The newly constructed set of deactivated layout edge constraints.
     */
    public func constraint(edges: UIRectEdge = .all,
                           equalTo anchors: LayoutEdgeAnchors,
                           constant: UIEdgeInsets = .zero) -> LayoutEdgeConstraints {

        guard !edges.isEmpty else {
            fatalError("At least one edge must be constrained")
        }
        
        let constraints = LayoutEdgeConstraints(
            top: edges.contains(.top) ? top.constraint(equalTo: anchors.top) : nil,
            left: edges.contains(.left) ? left.constraint(equalTo: anchors.left) : nil,
            bottom: edges.contains(.bottom) ? bottom.constraint(equalTo: anchors.bottom) : nil,
            right: edges.contains(.right) ? right.constraint(equalTo: anchors.right) : nil
        )
        
        constraints.constant = constant
        
        return constraints
    }
    
    public func constraint(edges: UIRectEdge = .all,
                           outsideOfOrEqualTo anchors: LayoutEdgeAnchors,
                           constant: UIEdgeInsets = .zero) -> LayoutEdgeConstraints {
        
        guard !edges.isEmpty else {
            fatalError("At least one edge must be constrained")
        }
        
        let topConstraint = edges.contains(.top) ? top.constraint(lessThanOrEqualTo: anchors.top, constant: constant.top) : nil
        let leftConstraint = edges.contains(.left) ? left.constraint(lessThanOrEqualTo: anchors.left, constant: constant.left) : nil
        let bottomConstraint = edges.contains(.bottom) ? bottom.constraint(greaterThanOrEqualTo: anchors.bottom, constant: -constant.bottom) : nil
        let rightConstraint = edges.contains(.right) ? right.constraint(greaterThanOrEqualTo: anchors.right, constant: -constant.right) : nil
        
        return LayoutEdgeConstraints(top: topConstraint, left: leftConstraint, bottom: bottomConstraint, right: rightConstraint)
    }
    
    public func constraint(edges: UIRectEdge = .all,
                           insideOfOrEqualTo anchors: LayoutEdgeAnchors,
                           constant: UIEdgeInsets = .zero) -> LayoutEdgeConstraints {
        
        guard !edges.isEmpty else {
            fatalError("At least one edge must be constrained")
        }
        
        let topConstraint = edges.contains(.top) ? top.constraint(greaterThanOrEqualTo: anchors.top, constant: constant.top) : nil
        let leftConstraint = edges.contains(.left) ? left.constraint(greaterThanOrEqualTo: anchors.left, constant: constant.left) : nil
        let bottomConstraint = edges.contains(.bottom) ? bottom.constraint(lessThanOrEqualTo: anchors.bottom, constant: -constant.bottom) : nil
        let rightConstraint = edges.contains(.right) ? right.constraint(lessThanOrEqualTo: anchors.right, constant: -constant.right) : nil
        
        return LayoutEdgeConstraints(top: topConstraint, left: leftConstraint, bottom: bottomConstraint, right: rightConstraint)
    }
}

public extension LayoutGuide {

    /// A group of edge layout anchors that can be used to create LayoutEdgeConstraints
    public var edgeAnchors: LayoutEdgeAnchors {
        return LayoutEdgeAnchors(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
}

public class LayoutEdgeConstraints {

    /// The top constraint.
    public let top: NSLayoutConstraint?

    /// The left constraint.
    public let left: NSLayoutConstraint?

    /// The bottom constraint.
    public let bottom: NSLayoutConstraint?

    /// The right constraint.
    public let right: NSLayoutConstraint?

    internal init(top: NSLayoutConstraint?, left: NSLayoutConstraint?, bottom: NSLayoutConstraint?, right: NSLayoutConstraint?) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }

    /// The agregation of all constants of the constraints
    public var constant: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: top?.constant ?? 0,
                                left: left?.constant ?? 0,
                                bottom: -(bottom?.constant ?? 0),
                                right: -(right?.constant ?? 0))
        }

        set {
            top?.constant = newValue.top
            left?.constant = newValue.left
            bottom?.constant = -newValue.bottom
            right?.constant = -newValue.right
        }
    }
}

extension LayoutEdgeConstraints: LayoutConstraintGroup {

    public var constraints: [NSLayoutConstraint] {
        return [top, left, bottom, right].flatMap {$0}
    }
}
