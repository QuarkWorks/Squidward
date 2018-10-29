//
//  CGRect+Squidward.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 10/23/18.
//  Copyright © 2018 QuarkWorks. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {

    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin = CGPoint(x: newValue.x - size.width / 2, y: newValue.y - size.height / 2)
        }
    }
}
