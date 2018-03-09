//
//  ForgotPasswordPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol ForgotPasswordPresenterDelegate: class {
    func userPerformedPasswordRecovery()
}

class ForgotPasswordPresenter {
    
    // MARK: Public properties
    
    weak var delegate: ForgotPasswordPresenterDelegate?
    
    // MARK: Private properties

    private weak var view: ForgotPasswordViewInterface!
    private let validator = Validator()
    
    // MARK: Public methods
    
    init(view: ForgotPasswordViewInterface) {
        self.view = view
    }
    
    // MARK: Private methods
    
    /// Returns value if it is valid. In other case returns nil.
    private func validateEmail(_ value: String?) -> String? {
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
}

// MARK: ForgotPasswordPresentation Protocol

extension ForgotPasswordPresenter: ForgotPasswordPresentation {
    func handleSubmitButtonTap() {
        view.hideKeyboard()
        let email = view.getEmailText()
        // perform some validation here
        if let _ = validateEmail(email) {
            // validation passed
            // show loading...
            // perform some url request
            // hide loading..
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
}
