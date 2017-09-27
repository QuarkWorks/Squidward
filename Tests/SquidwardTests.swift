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

import XCTest
import UIKit
@testable import Squidward

class SquidwardTests: XCTestCase {

    var superView: UIView!
    var view: UIView!

    override func setUp() {
        super.setUp()

        superView = UIView()
        view = UIView()

        [superView, view].forEach { $0?.translatesAutoresizingMaskIntoConstraints = false }
    
        superView.addSubview(view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEdgeConstraints() {

        var constraint: LayoutEdgeConstraints!
        let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)

        NSLayoutConstraint.activate([
            view.edgeAnchors.constraint(edges: .all, equalTo: superView.edgeAnchors, insets: insets)
                .assign(to: &constraint)
        ])

        XCTAssertEqual(insets, constraint.insets)
    }

    func testSizeConstraints() {

        var constraint: LayoutSizeConstraints!
        let size = CGSize(width: 10, height: 20)

        NSLayoutConstraint.activate([
            view.sizeAnchors.constraint(equalToConstant: size).assign(to: &constraint)
        ])

        XCTAssertEqual(size, constraint.constant)
    }

    func testPointConstraints(){
        var constraint: LayoutPointConstraints!
        let offset = UIOffset(horizontal: 10, vertical: 20)

        NSLayoutConstraint.activate([
            view.centerAnchors.constraint(eqaulTo: superView.centerAnchors, offset: offset).assign(to: &constraint)
        ])

        XCTAssertEqual(offset, constraint.constant)
    }
}
