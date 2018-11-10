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

public struct KeyboardFrameChange {

    public var isLocal: Bool

    public var beginFrame: CGRect
    public var endFrame: CGRect

    public var animationDurration: TimeInterval

    public var animationCurve: UIViewAnimationCurve

    public func beginFrame(for view: UIView) -> CGRect {
        return view.convert(beginFrame, from: nil)
    }

    public func endFrame(for view: UIView) -> CGRect {
        return view.convert(endFrame, from: nil)
    }

    public func animateAlong(_ animations: (() -> Void), completion: ((_ finished: Bool) -> Void)? = nil) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDurration)
        UIView.setAnimationCurve(animationCurve)
        UIView.setAnimationBeginsFromCurrentState(true)

        animations()

        UIView.commitAnimations()
    }
}

extension KeyboardFrameChange {

    public init?(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let isLocal = userInfo[UIKeyboardIsLocalUserInfoKey] as? Bool,
            let beginFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationDurration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let animationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int).flatMap(UIViewAnimationCurve.init(rawValue:))
            else {
                return nil
        }

        self.init(isLocal: isLocal, beginFrame: beginFrame, endFrame: endFrame, animationDurration: animationDurration, animationCurve: animationCurve)
    }
}

public final class KeyboardFrameChangeObserver: NSObject {

    public var onKeyboardWillShow: ((KeyboardFrameChange) -> Void)?
    public var onKeyboardDidShow: ((KeyboardFrameChange) -> Void)?

    public var onKeyboardWillChangeFrame: ((KeyboardFrameChange) -> Void)?
    public var onKeyboardDidChangeFrame: ((KeyboardFrameChange) -> Void)?

    public var onKeyboardWillHide: ((KeyboardFrameChange) -> Void)?
    public var onKeyboardDidHide: ((KeyboardFrameChange) -> Void)?

    private let notificationCenter: NotificationCenter

    public init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter

        super.init()

        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidChangeFrame(_:)), name: .UIKeyboardDidChangeFrame, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: .UIKeyboardDidHide, object: nil)
    }

    deinit {
        self.notificationCenter.removeObserver(self)
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let frameChange = KeyboardFrameChange(notification: notification) else { return }
        onKeyboardWillShow?(frameChange)
    }

    @objc
    private func keyboardDidShow(_ notification: Notification) {
        guard let frameChange = KeyboardFrameChange(notification: notification) else { return }
        onKeyboardDidShow?(frameChange)
    }

    @objc
    private func keyboardWillChangeFrame(_ notification: Notification) {
        guard let frameChange = KeyboardFrameChange(notification: notification) else { return }
        onKeyboardWillChangeFrame?(frameChange)
    }

    @objc
    private func keyboardDidChangeFrame(_ notification: Notification) {
        guard let frameChange = KeyboardFrameChange(notification: notification) else { return }
        onKeyboardDidChangeFrame?(frameChange)
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        guard let frameChange = KeyboardFrameChange(notification: notification) else { return }
        onKeyboardWillHide?(frameChange)
    }

    @objc
    private func keyboardDidHide(_ notification: Notification) {
        guard let frameChange = KeyboardFrameChange(notification: notification) else { return }
        onKeyboardDidHide?(frameChange)
    }
}
