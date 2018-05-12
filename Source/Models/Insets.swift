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

/// Backwards compatable version of `NSDirectionalEdgeInsets`.
public struct DirectionalEdgeInsets: Equatable {
    
    public static let zero = DirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    /// The top constant.
    public var top: CGFloat
    
    /// The leading constant.
    public var leading: CGFloat
    
    /// The bottom constant.
    public var bottom: CGFloat
    
    /// The trailing constant.
    public var trailing: CGFloat
    
    public init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
    
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.top = vertical
        self.leading = horizontal
        self.bottom = vertical
        self.trailing = horizontal
    }
    
    public init(all: CGFloat) {
        self.top = all
        self.leading = all
        self.bottom = all
        self.trailing = all
    }
    
    public var horizontalInsets: DirectionalHorizontalInsets {
        get {
            return DirectionalHorizontalInsets(leading: leading,
                                               trailing: trailing)
            
        }
        set {
            self.leading = newValue.leading
            self.trailing = newValue.trailing
        }
    }
        
    public var verticalInsets: VerticalInsets {
        get {
            return VerticalInsets(top: top, bottom: bottom)
        }
        set {
            top = newValue.top
            bottom = newValue.bottom
        }
    }
}

public struct HorizontalInsets: Equatable {
    
    public static var zero = HorizontalInsets(left: 0.0, right: 0.0)
    
    /// The left constant.
    public var left: CGFloat
    
    /// The right constatn.
    public var right: CGFloat
    
    public init(left: CGFloat, right: CGFloat) {
        self.left = left
        self.right = right
    }
    
    public init(all: CGFloat) {
        self.left = all
        self.right = all
    }
}

public struct DirectionalHorizontalInsets: Equatable {
    
    public static var zero = DirectionalHorizontalInsets(leading: 0.0, trailing: 0.0)
    
    /// The leading constant.
    public var leading: CGFloat
    
    /// The trailing constant.
    public var trailing: CGFloat
    
    public init(leading: CGFloat, trailing: CGFloat) {
        self.leading = leading
        self.trailing = trailing
    }
    
    public init(all: CGFloat) {
        self.leading = all
        self.trailing = all
    }
}

public struct VerticalInsets: Equatable {
    
    public static var zero = VerticalInsets(top: 0.0, bottom: 0.0)
    
    // The top constant.
    public var top: CGFloat
    
    // The bottom constant.
    public var bottom: CGFloat
    
    public init(top: CGFloat, bottom: CGFloat) {
        self.top = top
        self.bottom = bottom
    }
    
    public init(all: CGFloat) {
        self.top = all
        self.bottom = all
    }
}

public extension UIEdgeInsets {
    
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    public init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
    public var horizontalInsets: HorizontalInsets {
        get {
            return HorizontalInsets(left: left, right: right)
        }
        set {
            self.left = newValue.left
            self.right = newValue.right
        }
    }
    
    public var verticalInsets: VerticalInsets {
        get {
            return VerticalInsets(top: top, bottom: bottom)
        }
        
        set {
            top = newValue.top
            bottom = newValue.bottom
        }
    }
}

public extension CGSize {
    
    public init(all: CGFloat) {
        self.init(width: all, height: all)
    }
}

public extension UIOffset {
    
    public init(all: CGFloat) {
        self.init(horizontal: all, vertical: all)
    }
}
