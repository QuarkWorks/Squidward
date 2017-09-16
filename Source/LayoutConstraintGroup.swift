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

/// Any object that can store a group of constraints
public protocol LayoutConstraintGroup {

    /// The constraints that are grouped together.
    var constraints: [NSLayoutConstraint] {get}
}

public extension LayoutConstraintGroup {


    /**
     Activates the current constraint then returns them to allow for assignment or method chaining.

     - returns: The activated constraints.
     */
    @discardableResult
    public func activate() -> Self {
        constraints.forEach {$0.isActive = true}
        return self
    }

    /**
     Dectivates the current constraints then returns them to allow for assignment or method chaining.

     - returns: The deactivated constraints.
     */
    @discardableResult
    public func deactivate() -> Self {
        constraints.forEach {$0.isActive = true}
        return self
    }

    /**
     Sets the priority for the current constraints then returns them to allow for assignment or method chaining.

     - parameter priority: The priority of the constraints.

     - returns: The deactivated constraints.
     */
    @discardableResult
    public func prioritize(_ priority: UILayoutPriority) -> Self {
        constraints.forEach {$0.priority = priority}
        return self
    }

    /**
     Assigns passed in constraint to self. This allows for fluent assignment inside NSLayoutConstraint.activate()

     - parameter constraint: The constraint address that self will be assigned to

     - returns: self
     */
    @discardableResult
    public func assign(to target: inout Self) -> Self {
        target = self
        return self
    }

    /**
     Assigns passed in constraint to self. This allows for fluent assignment inside NSLayoutConstraint.activate()

     - parameter constraint: The constraint address that self will be assigned to

     - returns: self
     */
    @discardableResult
    public func assign(to target: inout Self?) -> Self {
        target = self
        return self
    }

    /**
     Assigns passed in constraint to self. This allows for fluent assignment inside NSLayoutConstraint.activate()

     - parameter constraint: The constraint address that self will be assigned to

     - returns: self
     */
    @discardableResult
    public func assign(to target: inout Self!) -> Self {
        target = self
        return self
    }
}


extension NSLayoutConstraint: LayoutConstraintGroup {

    /// Returns a list of one constraint only containing itself.
    public var constraints: [NSLayoutConstraint] {
        return [self]
    }
}

extension NSLayoutConstraint {

    /**
    Activates a list of constraint groups.
 
    - parameter constraints: The list of constraint groups.
    */
    public class func activate(_ constraints: [LayoutConstraintGroup]) {
        activate(constraints.flatMap {return $0.constraints})
    }

    /**
    Deactivates a list of constraint groups.

    - parameter constraints: The list of constraint groups.
     */
    public class func deactivate(_ constraints: [LayoutConstraintGroup]) {
        deactivate(constraints.flatMap {return $0.constraints})
    }
}
