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
import Squidward

class ArithmeticTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddition() {
        let pointOne = CGPoint(x: 1.0, y: 3.0)
        let pointTwo = CGPoint(x: 2.0, y: 4.0)

        let result = pointOne + pointTwo

        XCTAssertEqual(result.x, 3.0, accuracy: 0.0001)
        XCTAssertEqual(result.y, 7.0, accuracy: 0.00001)

    }

    func testSubtraction() {

        let pointOne = CGPoint(x: 1.0, y: 3.0)
        let pointTwo = CGPoint(x: 2.0, y: 5.0)

        let result = pointTwo - pointOne

        XCTAssertEqual(result.x, 1.0, accuracy: 0.00001)
        XCTAssertEqual(result.y, 2.0, accuracy: 0.00001)
    }

    func testMultiplication() {
        let pointOne = CGPoint(x: 1.0, y: 3.0)
        let result = pointOne * 2.0

        XCTAssertEqual(result.x, 2.0, accuracy: 0.0001)
        XCTAssertEqual(result.y, 6.0, accuracy: 0.0001)
    }

    func testDivision() {
        let pointOne = CGPoint(x: 2.0, y: 6.0)

        let result = pointOne / 2.0

        XCTAssertEqual(result.x, 1.0, accuracy: 0.0001)
        XCTAssertEqual(result.y, 3.0, accuracy: 0.0001)
    }

    func testDistance() {
        let startingPoint = CGPoint(x: 5.0, y: 35.0)
        let endingPoint = CGPoint(x: 20.0, y: 100.0)

        let distance = startingPoint.distance(to: endingPoint)

        XCTAssertEqual(distance, sqrt(4450))
    }

    func closestPointTest() {
        let points: [CGPoint] = [CGPoint(x: 0.0, y: 1.0),
                                 CGPoint(x: 0.0, y: 2.0),
                                 CGPoint(x: 0.0, y: 3.0)]
        let testPoint1 = CGPoint(x: 0.0, y: 3.0)
        let testResult1 = points.closestPoint(to: testPoint1)

        XCTAssert(testResult1 == CGPoint(x: 0.0, y: 3.0))

        XCTAssertEqual((testResult1?.x)!, testPoint1.x, accuracy: 0.0001)
        XCTAssertEqual((testResult1?.y)!, testPoint1.y, accuracy: 0.0001)

    }

    func closestValueTest() {
        let values: [CGFloat] = [CGFloat(1.0),
                                 CGFloat(2.0),
                                 CGFloat(4.0)]

        let testValue1 = CGFloat(5.0)
        let testResult = values.closestValue(to: testValue1)

        XCTAssertEqual((testResult)!, CGFloat(4.0), accuracy: CGFloat(0.0001))
    }

    func testMagnitude() {

        let vector = CGPoint(x: 2.0, y: 3.0)
        let magnitude: CGFloat = vector.magnitude

        XCTAssertEqual(magnitude, sqrt(13.0), accuracy: 0.0001)
    }

    func testNormalize() {
        let vector = CGPoint(x: 3.0, y: 4.0)

        let normalizedVector = vector.normalized
        let correctNormalizedVector = CGPoint(x: 3.0/5.0, y: 4.0/5.0)

        XCTAssertEqual(normalizedVector.x, correctNormalizedVector.x, accuracy: 0.0001)
        XCTAssertEqual(normalizedVector.y, correctNormalizedVector.y, accuracy: 0.0001)
    }
}
