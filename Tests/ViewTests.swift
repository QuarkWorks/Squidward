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

class ViewTests: XCTestCase {

    func testActionHandlers() {

        UIControl.swizzle_sendAction() // sendActions() doesn't work in a testing environment

        let button = UIButton()

        let exp1 = expectation(description: "Button Click 1")
        button.addHandler(for: .primaryActionTriggered) {
            exp1.fulfill()
        }

        let exp2 = expectation(description: "Button Click 2")
        button.addHandler(for: .primaryActionTriggered) {
            exp2.fulfill()
        }

        let exp3 = expectation(description: "Button Drag Outsize")
        button.addHandler(for: .touchDragOutside) {
            exp3.fulfill()
        }

        button.addHandler(for: .touchCancel) {
            XCTFail("Should never execute")
        }

        button.sendActions(for: [.touchDragOutside, .primaryActionTriggered])

        waitForExpectations(timeout: 0, handler: nil)
    }
}
