//
//  SignInPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol SignInPresenterDelegate: class {
    func handleSignUpButtonTap()
    func handleForgotPasswordButtonTap()
    func userPerformedAuthentication()
}

class SignInPresenter {

    // MARK: Public properties
    
    weak var delegate: SignInPresenterDelegate?
    
    // MARK: Private properties

    private weak var view: SignInViewInterface!
    private let userCredentialsStorage = UserCredentialsStorageService(storage: UserDefaultsLayer())
    
    // MARK: Public methods
    
    init(view: SignInViewInterface) {
        self.view = view
    }
    
    // MARK: Private methods
}

// MARK: SignInPresentation Protocol

extension SignInPresenter: SignInPresentation {
    func handleSignInButtonTap() {
        let email = view.getEmailString()
        let password = view.getPasswordString()
        // perform some validation here
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
    
    func handleSignUpButtonTap() {
        delegate?.handleSignUpButtonTap()
    }
    
    func handleForgotPasswordButtonTap() {
        delegate?.handleForgotPasswordButtonTap()
    }
}
