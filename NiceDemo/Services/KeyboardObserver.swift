//
//  KeyboardObserver.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 4/4/19.
//  Copyright © 2019 NiceDemo. All rights reserved.
//

import Foundation
import UIKit

/// Responsible for observing keyboard notifications like `UIKeyboardWillShow` or `UIKeyboardWillHide`
/// inside target(UIViewController, UIView etc.) and adopt target's view to fit
/// the screen, when keyboard is visible or not.
class KeyboardObserver {
    
    let targetView: UIScrollView?
    var keyboardWillShowHandler: ((_ notification: NSNotification) -> Void)?
    var keyboardWillHideHandler: ((_ notification: NSNotification) -> Void)?
    
    init(targetView: UIScrollView?) {
        self.targetView = targetView
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        targetView?.contentInset.bottom = keyboardFrame.size.height
        keyboardWillShowHandler?(notification)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        targetView?.contentInset = .zero
        keyboardWillHideHandler?(notification)
    }
}
