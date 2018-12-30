//
//  SignInContract.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol SignInViewInterface: class {
    func hideKeyboard()
    func getPasswordString() -> String?
    func getEmailString() -> String?
    func showAlert(title: String?, message: String?)
}

protocol SignInPresentation: class {
    func handleSignInButtonTap()
    func handleSkipButtonTap()
    func handleForgotPasswordButtonTap()
}
