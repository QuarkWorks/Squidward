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

extension UITableView {

    public func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func dequeueReusableCell<T: UITableViewCell>() -> T? {
        let identifier = T.reuseIdentifier
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T? else {
            fatalError("Reusable cell of type \(T.self) is not registered with identifier \(identifier)")
        }

        return cell
    }

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = T.reuseIdentifier
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("No reusable cell of type \(T.self) is registered with identifier \(identifier) for indexPath \(indexPath)")
        }

        return cell
    }

    public func autoDequeueReusableCell<T: UITableViewCell>() -> T {
        if autoCellRegistry.insert(T.reuseIdentifier).inserted {
            register(T.self)
        }

        guard let cell = dequeueReusableCell() as? T else { fatalError("Cell should already be registered") }
        return cell
    }

    public func autoDequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        if autoCellRegistry.insert(T.reuseIdentifier).inserted {
            register(T.self)
        }

        return dequeueReusableCell(for: indexPath)
    }

    private var autoCellRegistry: Set<String> {
        get { return (objc_getAssociatedObject(self, #function) as? Set<String>) ?? [] }
        set { objc_setAssociatedObject(self, #function, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

extension UITableView {

    public func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        register(aClass, forHeaderFooterViewReuseIdentifier: aClass.reuseIdentifier)
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? {
        let identifier = T.reuseIdentifier
        guard let reusableView = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T? else {
            fatalError("Reusable header footer view of type \(T.self) is not registered with identifier \(identifier)")
        }

        return reusableView
    }

    public func autoDequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        if autoHeaderFooterViewRegistry.insert(T.reuseIdentifier).inserted {
            registerHeaderFooterView(T.self)
        }

        guard let headerFooter = dequeueReusableHeaderFooterView() as? T else { fatalError("header footer should already be registered") }
        return headerFooter
    }

    private var autoHeaderFooterViewRegistry: Set<String> {
        get { return (objc_getAssociatedObject(self, #function) as? Set<String>) ?? [] }
        set { objc_setAssociatedObject(self, #function, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
