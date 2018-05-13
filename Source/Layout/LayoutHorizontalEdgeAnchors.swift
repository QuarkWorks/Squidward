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

public final class LayoutHorizontalEdgeAnchors {

    internal let left: NSLayoutXAxisAnchor

    internal let right: NSLayoutXAxisAnchor

    internal init(left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) {
        self.left = left
        self.right = right
    }

    public func constraint(equalTo anchors: LayoutHorizontalEdgeAnchors, constant: HorizontalInsets = .zero) -> LayoutHorizontalEdgeConstraints {
        return LayoutHorizontalEdgeConstraints(left: left.constraint(equalTo: anchors.left, constant: constant.left),
                                          right: right.constraint(equalTo: anchors.right, constant: -constant.right))
    }

    public func constraint(outsideOfOrEqualTo anchors: LayoutHorizontalEdgeAnchors, constant: HorizontalInsets = .zero) -> LayoutHorizontalEdgeConstraints {
        return LayoutHorizontalEdgeConstraints(left: left.constraint(lessThanOrEqualTo: anchors.left, constant: constant.left),
                                           right: right.constraint(greaterThanOrEqualTo: anchors.right, constant: -constant.right))
    }

    public func constraint(insideOfOrEqualTo anchors: LayoutHorizontalEdgeAnchors, constant: HorizontalInsets = .zero) -> LayoutHorizontalEdgeConstraints {
        return LayoutHorizontalEdgeConstraints(left: left.constraint(greaterThanOrEqualTo: anchors.left, constant: constant.left),
                                           right: right.constraint(lessThanOrEqualTo: anchors.right, constant: -constant.right))
    }
}

extension LayoutGuide {

    public var horizontalEdgeAnchors: LayoutHorizontalEdgeAnchors {
        return LayoutHorizontalEdgeAnchors(left: leftAnchor, right: rightAnchor)
    }
}

public final class LayoutHorizontalEdgeConstraints {

    public let left: NSLayoutConstraint

    public let right: NSLayoutConstraint

    internal init(left: NSLayoutConstraint, right: NSLayoutConstraint) {
        self.left = left
        self.right = right
    }

    public var constant: HorizontalInsets {
        get {
            return HorizontalInsets(left: left.constant,
                                    right: -right.constant)
        }

        set {
            left.constant = newValue.left
            right.constant = -newValue.right
        }
    }
}

extension LayoutHorizontalEdgeConstraints: LayoutConstraintGroup {

    public var constraints: [NSLayoutConstraint] {
        return [left, right]
    }
}
