//
//  ForgotPasswordPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol ForgotPasswordSceneDelegate: class {
    func userPerformedPasswordRecovery()
}

class ForgotPasswordPresenter {
    
    // MARK: Public properties
    
    weak var delegate: ForgotPasswordSceneDelegate?
    weak var view: ForgotPasswordViewInterface!
    let validator = Validator()
    
    // MARK: Public methods
    
    init(view: ForgotPasswordViewInterface) {
        self.view = view
    }
    
    /// Returns value if it is valid. In other case returns nil.
    func validateEmail(_ value: String?) -> String? {
        do {
            try validator.validateEmail(value)
        } catch let error as Validator.ValidationError {
            view.showAlert(title: nil, message: error.localizedDescription, completion: nil)
            return nil
        } catch {
            return nil
        }
        return value
    }
    
    func performPasswordRecovery(using email: String) {
        // perform some url request
        // handle result
        if true {
            view.showAlert(title: nil, message: "We sent you instructions for password recovery on your email.", completion: { [unowned self] in
                self.delegate?.userPerformedPasswordRecovery()
            })
        } else {
            // show appropriate UI, that error occured
        }
    }
}

// MARK: ForgotPasswordPresentation Protocol

extension ForgotPasswordPresenter: ForgotPasswordPresentation {
    func handleSubmitButtonTap() {
        view.hideKeyboard()
        let email = view.getEmailText()
        // perform some validation here
        if let validatededEmail = validateEmail(email) {
            // validation passed
            // show loading...
            performPasswordRecovery(using: validatededEmail)
            // hide loading..
        }
    }
}
