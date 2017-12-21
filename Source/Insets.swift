//
//  HorizontalInsets.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 12/6/17.
//  Copyright © 2017 QuarkWorks. All rights reserved.
//

import Foundation

/// Backwards compatable version of `NSDirectionalEdgeInsets`
public struct DirectionalEdgeInsets: Equatable {
    
    public static let zero = DirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    /// The top constant
    public var top: CGFloat
    
    /// The leading constant
    public var leading: CGFloat
    
    /// The bottom constant
    public var bottom: CGFloat
    
    /// The trailing constant
    public var trailing: CGFloat
    
    public init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
    
    public static func ==(lhs: DirectionalEdgeInsets, rhs: DirectionalEdgeInsets) -> Bool {
        return lhs.top == rhs.top
            && lhs.leading == rhs.leading
            && lhs.bottom == rhs.bottom
            && lhs.trailing == rhs.trailing
    }
}

public struct HorizontalInsets: Equatable {
    
    public static var zero = HorizontalInsets(left: 0.0, right: 0.0)
    
    public var left: CGFloat
    public var right: CGFloat
    
    public init(left: CGFloat, right: CGFloat) {
        self.left = left
        self.right = right
    }
    
    public static func ==(lhs: HorizontalInsets, rhs: HorizontalInsets) -> Bool {
        return lhs.left == rhs.left && lhs.right == lhs.right
    }
}

public struct DirectionalHorizontalInsets: Equatable {
    
    public static var zero = DirectionalHorizontalInsets(leading: 0.0, trailing: 0.0)
    
    public var leading: CGFloat
    public var trailing: CGFloat
    
    public init(leading: CGFloat, trailing: CGFloat) {
        self.leading = leading
        self.trailing = trailing
    }
    
    public static func ==(lhs: DirectionalHorizontalInsets, rhs: DirectionalHorizontalInsets) -> Bool {
        return lhs.leading == rhs.leading && lhs.trailing == lhs.trailing
    }
}

public struct VerticalInsets: Equatable {
    
    public static var zero = VerticalInsets(top: 0.0, bottom: 0.0)
    
    public var top: CGFloat
    public var bottom: CGFloat
    
    public init(top: CGFloat, bottom: CGFloat) {
        self.top = top
        self.bottom = bottom
    }
    
    public static func ==(lhs: VerticalInsets, rhs: VerticalInsets) -> Bool {
        return lhs.top == rhs.top && lhs.bottom == lhs.bottom
    }
}
