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

extension UIView {

    /// Adds a list of views to the end of the receiver’s list of subviews.
    public func addSubviews(_ subview: UIView, _ additionalSubviews: UIView...) {
        addSubviews([subview] + additionalSubviews)
    }

    /// Adds a list of views to the end of the receiver’s list of subviews.
    public func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(addSubview(_:))
    }

    /// Walks the view tree upward until a view without a superview is found.
    /// Returns `self` if it doesn't have a superview.
    public func rootview() -> UIView {
        return superview?.rootview() ?? self
    }

    /// Walks the view tree downwards and returns all the subviews.
    /// The result doesn't include `self`.
    public func allSubviews() -> [UIView] {
        return subviews.flatMap { $0.allSubviews()}
    }

    /// Returns a safe area insets or nil if not iOS 11.
    var safeAreaInsetsWrapper: UIEdgeInsets? {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        }

        return nil
    }

    /// Returns a safe area layout guide or nil if not iOS 11.
    var safeAreaLayoutGuideWrapper: UILayoutGuide? {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        }

        return nil
    }
}
