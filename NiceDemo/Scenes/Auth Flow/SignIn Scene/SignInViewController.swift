//
//  SignInViewController.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: BaseViewController {
    
    // MARK: Properties

    var presenter: SignInPresentation!
    lazy var customView = view as! SignInView
    
    // MARK: Lifecycle

    override func loadView() {
        view = SignInView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        showNavigationBar()
        subscribeOnCustomViewActions()
    }
    
    // MARK: Public methods
    
    func setPresenter(_ presenter: SignInPresentation) {
        self.presenter = presenter
    }
    
    func setupNavigationItem() {
        navigationItem.title = "Sign In"
        let signUpBarButtonItem = UIBarButtonItem(title: "Sign up", style: .done, target: self, action: #selector(signUpButtonTapped))
        signUpBarButtonItem.tintColor = .darkGray
        navigationItem.rightBarButtonItem = signUpBarButtonItem
    }
    
    @objc func signUpButtonTapped() {
    }
    
    func subscribeOnCustomViewActions() {
        customView.didPressForgotPasswordButton = { [unowned self] in
            self.presenter.handleForgotPasswordButtonTap()
        }
        customView.didPressSignInButton = { [unowned self] in
            self.presenter.handleSignInButtonTap()
        }
    }
}

// MARK: SignInViewInterface

extension SignInViewController: SignInViewInterface {
    func hideKeyboard() {
        dismissKeyboard()
    }
    
    func getPasswordString() -> String? {
        return customView.getPasswordText()
    }
    
    func getEmailString() -> String? {
        return customView.getEmailText()
    }
    
    func setEmailText(_ value: String) {
        customView.setEmailText(value)
    }
    
    func setPasswordText(_ value: String) {
        customView.setPasswordText(value)
    }
    
    func showAlert(title: String?, message: String?) {
        presentAlert(title: title, message: message)
    }
}
