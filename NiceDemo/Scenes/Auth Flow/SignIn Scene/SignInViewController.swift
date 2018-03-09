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
        customView.didPressForgotPasswordButton = { [unowned self] in
            self.presenter.handleForgotPasswordButtonTap()
        }
        customView.didPressSignInButton = { [unowned self] in
            self.presenter.handleSignInButtonTap()
        }
    }
}

// MARK: SignInView Protocol

extension SignInViewController: SignInViewInterface {
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func getPasswordString() -> String? {
        return customView.getEmailText()
    }
    
    func getEmailString() -> String? {
        return customView.getPasswordText()
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okey", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
