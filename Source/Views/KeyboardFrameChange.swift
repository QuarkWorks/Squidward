//
//  KeyboardFrameChange.swift
//  Squidward
//
//  Created by Brandon Erbschloe on 10/2/18.
//  Copyright © 2018 QuarkWorks. All rights reserved.
//

import Foundation

public struct KeyboardFrameChange {

    public var isLocal: Bool

    public var beginFrame: CGRect
    public var endFrame: CGRect

    public var animationDurration: TimeInterval

    public var animationCurve: UIView.AnimationCurve

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
            let animationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int).flatMap(UIView.AnimationCurve.init(rawValue:))
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

    init(notificationCenter: NotificationCenter = .default) {
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
