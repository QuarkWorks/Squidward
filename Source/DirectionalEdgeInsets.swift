//
//  DirectionalEdgeInsets.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 11/20/17.
//  Copyright © 2017 QuarkWorks. All rights reserved.
//

import Foundation

/// Backwards compatable version of NSDirectionalEdgeInsets
public struct DirectionalEdgeInsets: Equatable {
    
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
    
    public static let zero = DirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
}
