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

import Foundation

/// Enum for specifying a single rect edge
public enum RectEdge {
    case top, left, bottom, right
    
    internal func xAxisAnchor(for layoutGuide: LayoutGuide) -> NSLayoutXAxisAnchor {
        switch self {
        case .top, .bottom:
            return layoutGuide.centerXAnchor
        case .left:
            return layoutGuide.leftAnchor
        case .right:
            return layoutGuide.rightAnchor
        }
    }
    
    internal func yAxisAnchor(for layoutGuide: LayoutGuide) -> NSLayoutYAxisAnchor {
        switch self {
        case .left, .right:
            return layoutGuide.centerYAnchor
        case .top:
            return layoutGuide.topAnchor
        case .bottom:
            return layoutGuide.bottomAnchor
        }
    }
    
    public static let all: Set<RectEdge> = [.top, .left, .bottom, .right]
}

/// Localized enum for specifying a single rect edge
public enum DirectionalRectEdge {
    case top, leading, bottom, trailing
    
    internal func xAxisAnchor(for layoutGuide: LayoutGuide) -> NSLayoutXAxisAnchor {
        switch self {
        case .top, .bottom:
            return layoutGuide.centerXAnchor
        case .leading:
            return layoutGuide.leadingAnchor
        case .trailing:
            return layoutGuide.trailingAnchor
        }
    }
    
    internal func yAxisAnchor(for layoutGuide: LayoutGuide) -> NSLayoutYAxisAnchor {
        switch self {
        case .leading, .trailing:
            return layoutGuide.centerYAnchor
        case .top:
            return layoutGuide.topAnchor
        case .bottom:
            return layoutGuide.bottomAnchor
        }
    }
    
    public static let all: Set<DirectionalRectEdge> = [.top, .leading, .bottom, .trailing]
}

/// Enum for specifying a single rect corner
public enum RectCorner {
    case topLeft, topRight, bottomLeft, bottomRight
    
    internal func xAxisAnchor(for layoutGuide: LayoutGuide) -> NSLayoutXAxisAnchor {
        switch self {
        case .topLeft, .bottomLeft:
            return layoutGuide.leftAnchor
        case .topRight, .bottomRight:
            return layoutGuide.rightAnchor
        }
    }
    
    internal func yAxisAnchor(for layoutGuide: LayoutGuide) -> NSLayoutYAxisAnchor {
        switch self {
        case .topLeft, .topRight:
            return layoutGuide.topAnchor
        case .bottomLeft, .bottomRight:
            return layoutGuide.bottomAnchor
        }
    }
}

/// Localized enum for specifying a single rect corner
public enum DirectionalRectCorner {
    case topLeading, topTrailing, bottomLeading, bottomTrailing
    
    internal func xAxisAnchor(for layoutGuide: LayoutGuide) -> NSLayoutXAxisAnchor {
        switch self {
        case .topLeading, .bottomLeading:
            return layoutGuide.leadingAnchor
        case .topTrailing, .bottomTrailing:
            return layoutGuide.trailingAnchor
        }
    }
    
   internal func yAxisAnchor(for layoutGuide: LayoutGuide) -> NSLayoutYAxisAnchor {
        switch self {
        case .topLeading, .topTrailing:
            return layoutGuide.topAnchor
        case .bottomLeading, .bottomTrailing:
            return layoutGuide.bottomAnchor
        }
    }
}
