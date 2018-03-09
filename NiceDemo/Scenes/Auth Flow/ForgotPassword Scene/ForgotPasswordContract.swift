//
//  ForgotPasswordContract.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol ForgotPasswordViewInterface: class {
    func hideKeyboard()
    func getEmailText() -> String?
    func showAlert(title: String?, message: String?, completion: (() -> Void)?)
}

protocol ForgotPasswordPresentation: class {
    func handleSubmitButtonTap()
}
