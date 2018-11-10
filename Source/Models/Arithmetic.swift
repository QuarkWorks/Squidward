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
