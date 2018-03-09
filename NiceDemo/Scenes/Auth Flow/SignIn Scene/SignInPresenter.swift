//
//  SignInPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol SignInSceneDelegate: class {
    func handleSignUpButtonTap()
    func handleForgotPasswordButtonTap()
    func userPerformedAuthentication()
}

class SignInPresenter {

    // MARK: Public properties
    
    weak var delegate: SignInSceneDelegate?
    
    // MARK: Private properties

    private weak var view: SignInViewInterface!
    private let userCredentialsStorage = UserCredentialsStorageService(storage: UserDefaultsLayer())
    private let validator = Validator()
    
    // MARK: Public methods
    
    init(view: SignInViewInterface) {
        self.view = view
    }
    
    // MARK: Private methods
    
    /// Returns value if it is valid. In other case returns nil.
    private func validateEmail(_ value: String?) -> String? {
        do {
            try validator.validateEmail(value)
        } catch let error as Validator.ValidationError {
            view.showAlert(title: nil, message: error.localizedDescription)
            return nil
        } catch {
            return nil
        }
        return value
    }
    
    /// Returns value if it is valid. In other case returns nil.
    private func validatePassword(_ value: String?) -> String? {
        do {
            try validator.validatePassword(value)
        } catch let error as Validator.ValidationError {
           view.showAlert(title: nil, message: error.localizedDescription)
            return nil
        } catch {
            return nil
        }
        return value
    }
}

// MARK: SignInPresentation Protocol

extension SignInPresenter: SignInPresentation {
    func handleSignInButtonTap() {
        let email = view.getEmailString()
        let password = view.getPasswordString()
        // perform some validation here
        if let _ = validateEmail(email), let _ = validatePassword(password) {
            // validation passed
            // show loading...
            // perform some url request
            // hide loading..
            // handle result
            if true {
                // we store, that user authenticated successfully
                userCredentialsStorage.isUserAuthenticated = true
                delegate?.userPerformedAuthentication()
            } else {
                // show appropriate UI, that error occured
            }
        }
    }
    
    func handleSignUpButtonTap() {
        delegate?.handleSignUpButtonTap()
    }
    
    func handleForgotPasswordButtonTap() {
        delegate?.handleForgotPasswordButtonTap()
    }
}
