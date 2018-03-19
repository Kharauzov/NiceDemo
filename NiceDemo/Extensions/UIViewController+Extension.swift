//
//  UIViewController+Extension.swift
//
//
//  Created by Serhii Kharauzov on 1/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: ReusableView, Alertable {}

extension UIViewController {
    /// Hides keyboard of active textField of `UIViewController`.
    func dismissKeyboard(force: Bool = true) {
        view.endEditing(true)
    }
}
