//
//  Arithmetic.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 9/17/18.
//  Copyright © 2018 QuarkWorks. All rights reserved.
//

import Foundation
import UIKit

public func expectedDistanceToTravel(for velocity: CGPoint, friction: CGFloat = 20, gravity: CGFloat = 10000.0) -> CGPoint {
    return velocity.normalized * (pow(velocity.magnitude, 2.0) / (2.0 * friction * gravity))
}

public func expectedDistanceToTravel(for velocity: CGFloat, friction: CGFloat = 10.0, gravity: CGFloat = 1000.0) -> CGFloat {
    return velocity * (pow(velocity, 2.0) / (2.0 * friction * gravity))
}

extension CGPoint {
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    public static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    public static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

extension CGSize {
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }

    public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }
}

extension Array where Element == CGPoint {

    public func closestPoint(to point: CGPoint) -> CGPoint? {
        guard let firstPoint = self.first else {
            return nil
        }

        return reduce(firstPoint) { (closestPoint, nextPoint) -> CGPoint in
            return nextPoint.distance(to: point) < closestPoint.distance(to: point)
                ? nextPoint : closestPoint
        }
    }
}

extension Array where Element == CGFloat {

    public func closestValue(to value: CGFloat) -> CGFloat? {

        guard let firstValue = self.first else {
            return nil
        }

        if value.isNaN {
            return nil
        }

        return reduce(firstValue) { (closestValue, nextValue) -> CGFloat in
            if abs(value - nextValue) < abs(value - closestValue) {
                return nextValue
            }
            return closestValue
        }
    }
}

extension CGPoint {

    public func distance(to point: CGPoint) -> CGFloat {
        let xDelta = x - point.x
        let yDelta = y - point.y
        let squaredValue = pow(xDelta, 2.0) + pow(yDelta, 2.0)

        return sqrt(squaredValue)
    }

    public var magnitude: CGFloat {
        return CGFloat(sqrt(pow(x, 2.0) + pow(y, 2.0)))
    }

    public var normalized: CGPoint {
        let magnitude = self.magnitude
        return CGPoint(x: x / magnitude, y: y / magnitude)
    }
}
