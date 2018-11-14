//
//  VerticalInsets.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 11/14/18.
//  Copyright © 2018 QuarkWorks. All rights reserved.
//

import Foundation

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
}
