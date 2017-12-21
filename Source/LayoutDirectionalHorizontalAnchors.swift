//
//  Squidward
//
//  Copytrailing (c) 2017 - Present QuarkWorks - https://github.com/quarkworks
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the trailings
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copytrailing notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYtrailing HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public final class LayoutDirectionalHorizontalAnchors {
    
    public let leading: NSLayoutXAxisAnchor
    
    public let trailing: NSLayoutXAxisAnchor
    
    internal init(leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        self.leading = leading
        self.trailing = trailing
    }
    
    public func constraint(equalTo anchors: LayoutDirectionalHorizontalAnchors, constant: CGFloat = 0.0) -> LayoutDirectionalHorizonalConstraints {
        return constraint(equalTo: anchors, constant: DirectionalHorizontalInsets(leading: constant, trailing: constant))
    }
    
    public func constraint(equalTo anchors: LayoutDirectionalHorizontalAnchors, constant: DirectionalHorizontalInsets) -> LayoutDirectionalHorizonalConstraints {
        return LayoutDirectionalHorizonalConstraints(leading: leading.constraint(equalTo: anchors.leading, constant: constant.leading),
                                                     trailing: trailing.constraint(equalTo: anchors.trailing, constant: -constant.trailing))
    }
}

extension LayoutGuide {
    
    public var directionalHorizontalAnchors: LayoutDirectionalHorizontalAnchors {
        return LayoutDirectionalHorizontalAnchors(leading: leadingAnchor, trailing: trailingAnchor)
    }
}

public final class LayoutDirectionalHorizonalConstraints {
    
    public let leading: NSLayoutConstraint
    
    public let trailing: NSLayoutConstraint
    
    internal init(leading: NSLayoutConstraint, trailing: NSLayoutConstraint) {
        self.leading = leading
        self.trailing = trailing
    }
    
    public var constant: DirectionalHorizontalInsets {
        get {
            return DirectionalHorizontalInsets(leading: leading.constant, trailing: -trailing.constant)
        }
        
        set {
            leading.constant = newValue.leading
            trailing.constant = -newValue.trailing
        }
    }
}

extension LayoutDirectionalHorizonalConstraints: LayoutConstraintGroup {
    
    public var constraints: [NSLayoutConstraint] {
        return [leading, trailing]
    }
}
