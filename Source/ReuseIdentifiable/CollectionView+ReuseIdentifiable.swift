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

extension UICollectionView {

    public func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = T.reuseIdentifier
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("No reusable cell of type \(T.self) is registered with identifier \(identifier) for indexPath \(indexPath)")
        }

        return cell
    }

    public func autoDequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
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

extension UICollectionView {

    public func registerSupplementaryView<T: UICollectionReusableView>(_ viewClass: T.Type) where T: CollectionViewSupplementaryElement {
        register(viewClass, forSupplementaryViewOfKind: T.supplementaryElementKind, withReuseIdentifier: viewClass.reuseIdentifier)
    }

    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T where T: CollectionViewSupplementaryElement {
        let identifier = T.reuseIdentifier
        let kind = T.supplementaryElementKind
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("No supplementary view of type \(T.self) is registered with identifier \(identifier) of kind \(kind)")
        }

        return cell
    }

    public func autoDequeReusableSupplementaryView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T where T: CollectionViewSupplementaryElement {
        if autoReusableSupplementaryViewRegistry.insert(T.reuseIdentifier).inserted {
            registerSupplementaryView(T.self)
        }

        return dequeueReusableSupplementaryView(for: indexPath)
    }

    private var autoReusableSupplementaryViewRegistry: Set<String> {
        get { return (objc_getAssociatedObject(self, #function) as? Set<String>) ?? [] }
        set { objc_setAssociatedObject(self, #function, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
