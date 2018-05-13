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

public class LayoutDirectionalEdgeAnchors {

    /// The top anchor.
    internal let top: NSLayoutYAxisAnchor

    /// The leading anchor.
    internal let leading: NSLayoutXAxisAnchor

    /// The bottom anchor.
    internal let bottom: NSLayoutYAxisAnchor

    /// The trailing anchor
    internal let trailing: NSLayoutXAxisAnchor

    internal init(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor,
                  bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor) {

        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }

    /**
     Constrains a list of provided edges to another view's anchors with insets.
     At least one edge must be constrained.
     
     - parameter edges: The edges that should be constrained.
     - parameter anchors: The the target anchors to be constrained to.
     - parameter constant: Insets that is applied to all the provided edges.

     - returns: The newly constructed set of deactivated layout edge constraints.
     */
    public func constraint(edges: DirectionalRectEdge = .all,
                           equalTo anchors: LayoutDirectionalEdgeAnchors,
                           constant: DirectionalEdgeInsets = .zero) -> LayoutDirectionalEdgeConstraints {

        guard !edges.isEmpty else {
            fatalError("At least one edge must be constrained")
        }

        let topConstraint = edges.contains(.top) ? top.constraint(equalTo: anchors.top, constant: constant.top) : nil
        let leadingConstraint = edges.contains(.leading) ? leading.constraint(equalTo: anchors.leading, constant: constant.leading) : nil
        let bottomConstraint = edges.contains(.bottom) ? bottom.constraint(equalTo: anchors.bottom, constant: constant.bottom) : nil
        let trailingConstraint = edges.contains(.trailing) ? trailing.constraint(equalTo: anchors.trailing, constant: constant.trailing) : nil

        return LayoutDirectionalEdgeConstraints(top: topConstraint, leading: leadingConstraint, bottom: bottomConstraint, trailing: trailingConstraint)
    }

    public func constraint(edges: DirectionalRectEdge = .all,
                           outsideOfOrEqualTo anchors: LayoutDirectionalEdgeAnchors,
                           constant: DirectionalEdgeInsets = .zero) -> LayoutDirectionalEdgeConstraints {

        guard !edges.isEmpty else {
            fatalError("At least one edge must be constrained")
        }

        let topConstraint = edges.contains(.top) ? top.constraint(lessThanOrEqualTo: anchors.top, constant: constant.top) : nil
        let leadingConstraint = edges.contains(.leading) ? leading.constraint(lessThanOrEqualTo: anchors.leading, constant: constant.leading) : nil
        let bottomConstraint = edges.contains(.bottom) ? bottom.constraint(greaterThanOrEqualTo: anchors.bottom, constant: constant.bottom) : nil
        let trailingConstraint = edges.contains(.trailing) ? trailing.constraint(greaterThanOrEqualTo: anchors.trailing, constant: constant.trailing) : nil

        return LayoutDirectionalEdgeConstraints(top: topConstraint, leading: leadingConstraint, bottom: bottomConstraint, trailing: trailingConstraint)
    }

    public func constraint(edges: DirectionalRectEdge = .all,
                           insideOfOrEqualTo anchors: LayoutDirectionalEdgeAnchors,
                           constant: DirectionalEdgeInsets = .zero) -> LayoutDirectionalEdgeConstraints {

        guard !edges.isEmpty else {
            fatalError("At least one edge must be constrained")
        }

        let topConstraint = edges.contains(.top) ? top.constraint(greaterThanOrEqualTo: anchors.top, constant: constant.top) : nil
        let leadingConstraint = edges.contains(.leading) ? leading.constraint(greaterThanOrEqualTo: anchors.leading, constant: constant.leading) : nil
        let bottomConstraint = edges.contains(.bottom) ? bottom.constraint(lessThanOrEqualTo: anchors.bottom, constant: constant.bottom) : nil
        let trailingConstraint = edges.contains(.trailing) ? trailing.constraint(lessThanOrEqualTo: anchors.trailing, constant: constant.trailing) : nil

        return LayoutDirectionalEdgeConstraints(top: topConstraint, leading: leadingConstraint, bottom: bottomConstraint, trailing: trailingConstraint)
    }
}

public extension LayoutGuide {

    /// A group of edge layout anchors that can be used to create LayoutEdgeConstraints
    public var directionalEdgeAnchors: LayoutDirectionalEdgeAnchors {
        return LayoutDirectionalEdgeAnchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}

public class LayoutDirectionalEdgeConstraints {

    /// The top constraint.
    public let top: NSLayoutConstraint?

    /// The left constraint.
    public let leading: NSLayoutConstraint?

    /// The bottom constraint.
    public let bottom: NSLayoutConstraint?

    /// The right constraint.
    public let trailing: NSLayoutConstraint?

    internal init(top: NSLayoutConstraint?, leading: NSLayoutConstraint?, bottom: NSLayoutConstraint?, trailing: NSLayoutConstraint?) {
        self.top = top
        self.bottom = bottom
        self.leading = leading
        self.trailing = trailing
    }

    /// The agregation of all constants of the constraints
    public var constant: DirectionalEdgeInsets {
        get {
            return DirectionalEdgeInsets(top: top?.constant ?? 0,
                                leading: leading?.constant ?? 0,
                                bottom: bottom?.constant ?? 0,
                                trailing: trailing?.constant ?? 0)
        }

        set {
            top?.constant = newValue.top
            leading?.constant = newValue.leading
            bottom?.constant = -newValue.bottom
            trailing?.constant = -newValue.trailing
        }
    }
}

extension LayoutDirectionalEdgeConstraints: LayoutConstraintGroup {

    public var constraints: [NSLayoutConstraint] {
        return [top, leading, bottom, trailing].compactMap { $0 }
    }
}
