//
//  Alertable.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/19/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

/// Defines protocol for presenting `UIAlertController`.
protocol Alertable {
    /// Defines method for presenting `UIAlertController`.
    func presentAlert(title: String?, message: String?, defaultButtonTitle: String?, completion: (() -> Void)?)
}

extension Alertable where Self: UIViewController {
    func presentAlert(title: String?, message: String?, defaultButtonTitle: String? = "Okay", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: defaultButtonTitle, style: .default, handler: { (action) in
            completion?()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
