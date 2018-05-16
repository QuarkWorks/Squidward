//
//  UIImage+Squidward.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 5/16/18.
//  Copyright © 2018 QuarkWorks. All rights reserved.
//

import UIKit

public extension UIImage {

    public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContext(rect.size)

        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        self.init(cgImage: image.cgImage!)
    }
}
