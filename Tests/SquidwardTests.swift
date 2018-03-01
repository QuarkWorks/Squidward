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
import Squidward

class SquidwardTests: XCTestCase {

    var superView: UIView!
    var view: UIView!
    var otherView: UIView!

    override func setUp() {
        super.setUp()

        superView = UIView()
        view = UIView()
        otherView = UIView()

        [superView, view, otherView].forEach { $0?.translatesAutoresizingMaskIntoConstraints = false }
        [view, otherView].forEach { superView.addSubview($0) }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEdgeConstraints() {

        var constraint: LayoutEdgeConstraints!
        let insets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)

        NSLayoutConstraint.activate([
            view.edgeAnchors.constraint(equalTo: superView.edgeAnchors, constant: insets)
                .assign(to: &constraint)
        ])

        XCTAssertEqual(insets, constraint.constant)
    }
    
    func testDirectionalEdgeConstraints() {
        
        var constraint: LayoutDirectionalEdgeConstraints!
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        
        NSLayoutConstraint.activate([
            view.directionalEdgeAnchors.constraint(equalTo: superView.directionalEdgeAnchors, constant: insets)
                .assign(to: &constraint)
            ])
        
        XCTAssertEqual(insets, constraint.constant)
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
            view.centerAnchors.constraint(eqaulTo: superView.centerAnchors, constant: offset).assign(to: &constraint)
        ])

        XCTAssertEqual(offset, constraint.constant)
    }
    
    func testHorizontalConstraints() {
        
        var constraint: LayoutHorizontalEdgeConstraints!
        let insets = HorizontalInsets(left: 10, right: 20)
        
        NSLayoutConstraint.activate([
            view.horizontalEdgeAnchors.constraint(equalTo: superView.horizontalEdgeAnchors, constant: insets).assign(to: &constraint)
        ])
        
        XCTAssertEqual(insets, constraint.constant)
    }
    
    func testDirectionalHorizontalConstraints() {
        
        var constraint: LayoutDirectionalHorizonalConstraints!
        let insets = DirectionalHorizontalInsets(leading: 10, trailing: 20)
        
        NSLayoutConstraint.activate([
            view.directionalHorizontalEdgeAnchors.constraint(equalTo: superView.directionalHorizontalEdgeAnchors, constant: insets).assign(to: &constraint)
        ])
        
        XCTAssertEqual(insets, constraint.constant)
    }
    
    func testVerticalConstraints() {
        
        var constraint: LayoutVerticalEdgeConstraints!
        let insets = VerticalInsets(top: 10, bottom: 20)
        
        NSLayoutConstraint.activate([
            view.verticalEdgeAnchors.constraint(equalTo: superView.verticalEdgeAnchors, constant: insets).assign(to: &constraint)
        ])
        
        XCTAssertEqual(insets, constraint.constant)
    }
    
    func testWrapContent() {
        
        let viewSize = CGSize(width: 100, height: 105)
        let otherViewSize = CGSize(width: 110, height: 115)
        
        let viewInsets = UIEdgeInsets(horizontal: 5, vertical: 10)
        let otherViewInsets = UIEdgeInsets(horizontal: 15, vertical: 20)
        
        NSLayoutConstraint.activate([
            view.sizeAnchors.constraint(equalToConstant: viewSize),
            otherView.sizeAnchors.constraint(equalToConstant: otherViewSize),
            
            view.edgeAnchors.constraint(insideOfOrEqualTo: superView.edgeAnchors, constant: viewInsets),
            otherView.edgeAnchors.constraint(insideOfOrEqualTo: superView.edgeAnchors, constant: otherViewInsets),
            
            otherView.topLeftAnchors.constraint(eqaulTo: view.bottomRightAnchors)
        ])

        // update view frames
        superView.layoutIfNeeded()
        superView.updateConstraints()
        
        let expectedViewSize = CGSize(width: viewSize.width + otherViewSize.width + viewInsets.left + otherViewInsets.right,
                              height: viewSize.height + otherViewSize.height + viewInsets.top + otherViewInsets.bottom)
        
        XCTAssertEqual(expectedViewSize, superView.frame.size)
    }
}
