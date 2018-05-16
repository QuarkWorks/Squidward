//
//  ReuseIdentifiableTests.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 5/16/18.
//  Copyright © 2018 QuarkWorks. All rights reserved.
//

import XCTest
import UIKit
import Squidward

class TestTableViewCell: UITableViewCell {}
class TestTableViewHeaderFooterView: UITableViewHeaderFooterView {}
class TestCollectionViewCell: UICollectionViewCell {}
class TestCollectionReusableView: UICollectionReusableView {}

class ReuseIdentifiableTests: XCTestCase {

    func testReuseIdentifiable() {

        let moduleName = String(reflecting: type(of: self)).components(separatedBy: ".").first!

        XCTAssertEqual("UITableViewCell", UITableViewCell.reuseIdentifier)
        XCTAssertEqual("UITableViewHeaderFooterView", UITableViewHeaderFooterView.reuseIdentifier)

        XCTAssertEqual("\(moduleName).TestTableViewCell", TestTableViewCell.reuseIdentifier)
        XCTAssertEqual("\(moduleName).TestCollectionViewCell", TestCollectionViewCell.reuseIdentifier)

        XCTAssertEqual("UICollectionViewCell", UICollectionViewCell.reuseIdentifier)
        XCTAssertEqual("UICollectionReusableView", UICollectionReusableView.reuseIdentifier)

        XCTAssertEqual("\(moduleName).TestCollectionViewCell", TestCollectionViewCell.reuseIdentifier)
        XCTAssertEqual("\(moduleName).TestCollectionReusableView", TestCollectionReusableView.reuseIdentifier)
    }
}
