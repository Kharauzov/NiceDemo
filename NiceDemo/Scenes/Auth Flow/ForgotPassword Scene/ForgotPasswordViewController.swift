//
//  ForgotPasswordViewController.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordViewController: BaseViewController {
    
    // MARK: Private properties

    private var presenter: ForgotPasswordPresentation!
    private lazy var customView = view as! ForgotPasswordView
    
    // MARK: Lifecycle

    override func loadView() {
        view = ForgotPasswordView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recover password"
        subscribeOnCustomViewActions()
    }
    
    // MARK: Public methods
    
    func setPresenter(_ presenter: ForgotPasswordPresentation) {
        self.presenter = presenter
    }
    
    // MARK: Private methods
    
    private func subscribeOnCustomViewActions() {
        customView.didPressSubmitButton = { [unowned self] in
            self.presenter.handleSubmitButtonTap()
        }
    }
}

// MARK: ForgotPasswordView Protocol

extension ForgotPasswordViewController: ForgotPasswordViewInterface {
    func hideKeyboard() {
        dismissKeyboard()
    }
    
    func getEmailText() -> String? {
        return customView.getEmailText()
    }
    
    func showAlert(title: String?, message: String?, completion: (() -> Void)?) {
        presentAlert(title: title, message: message, defaultButtonTitle: "Okay") {
            completion?()
        }
    }
}
