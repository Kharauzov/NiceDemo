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
    
    // MARK: Private properties

    private var presenter: SignInPresentation!
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
    
    // MARK: Private methods
    
    private func setupNavigationItem() {
        navigationItem.title = "Sign In"
        let signUpBarButtonItem = UIBarButtonItem(title: "Sign up", style: .done, target: self, action: #selector(signUpButtonTapped))
        signUpBarButtonItem.tintColor = .darkGray
        navigationItem.rightBarButtonItem = signUpBarButtonItem
    }
    
    @objc private func signUpButtonTapped() {
        debugPrint(#function)
    }
    
    private func subscribeOnCustomViewActions() {
        customView.didPressForgotPasswordButton = {
            debugPrint(#function)
        }
        customView.didPressSignInButton = {
            debugPrint(#function)
        }
    }
}

// MARK: SignInView Protocol

extension SignInViewController: SignInViewInterface {
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func getPasswordString() -> String? {
        return customView.passwordTextField.text
    }
    
    func getEmailString() -> String? {
        return customView.emailTextField.text
    }
}
