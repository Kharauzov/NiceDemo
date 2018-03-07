//
//  Validator.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/7/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

/// Responsible to validate different data.
class Validator {
    
    // MARK: Public methods
    
    func validateEmail(_ value: String?) throws {
        guard let email = value else {
            throw ValidationError.valueIsEmpty("Email")
        }
        if email.isEmpty {
            throw ValidationError.valueIsEmpty("Email")
        } else if !isValidEmail(email) {
            throw ValidationError.emailFormatIsWrong
        }
    }
    
    func validatePassword(_ value: String?) throws {
        guard let password = value else {
            throw ValidationError.valueIsEmpty("Password")
        }
        if password.isEmpty {
            throw ValidationError.valueIsEmpty("Password")
        } else if password.count < Constants.passwordRequiredLength {
            throw ValidationError.passwordLengthIsWrong
        }
    }
    
    // MARK: Private methods
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}

extension Validator {
    /// Represents error type with detailed description.
    enum ValidationError: Error {
        case emailFormatIsWrong
        case emailFormatIsDublicated
        case passwordLengthIsWrong
        case valueIsEmpty(String)
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .emailFormatIsWrong:
                return "Email has wrong format. Please edit it."
            case .emailFormatIsDublicated:
                return "This email is already used by other user. Please try another one."
            case .passwordLengthIsWrong:
                return "Password must have minimum \(Constants.passwordRequiredLength) symbols."
            case .valueIsEmpty(let value):
                return "\(value) is empty. Please fill it."
            default:
                return "Unknown error occured."
            }
        }
    }
}
