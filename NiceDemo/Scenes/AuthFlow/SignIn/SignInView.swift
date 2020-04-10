//
//  SignInView.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

class SignInView: UIView {

    // MARK: Properties

    var didPressSignInButton: (() -> Void)?
    var didPressForgotPasswordButton: (() -> Void)?
    private lazy var forgotPasswordButton: UIButton = {
        let forgotPasswordButton = UIButton(type: .roundedRect)
        forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        forgotPasswordButton.setTitleColor(UIColor.AppColors.primaryColor, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        forgotPasswordButton.addTarget(self, action: #selector(forgotButtonTapped(_:)), for: .touchUpInside)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        return forgotPasswordButton
    }()
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton(type: .roundedRect)
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(UIColor.AppColors.secondaryColor, for: .normal)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        signInButton.layer.cornerRadius = 10.0
        signInButton.backgroundColor = UIColor.AppColors.primaryColor
        signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        return signInButton
    }()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.textContentType = UITextContentType(rawValue: "")
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.textContentType = UITextContentType(rawValue: "")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "dog").withRenderingMode(.alwaysTemplate))
        imageView.tintColor = UIColor.AppColors.primaryColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addLogoImageView()
        addEmailTextField()
        addPasswordTextField()
        addForgotPasswordButton()
        addSignInButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func addLogoImageView() {
        addSubview(logoImageView)
        if #available(iOS 11.0, *), DeviceType.hasTopNotch {
            NSLayoutConstraint(item: logoImageView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 44).isActive = true
        }
        else {
            NSLayoutConstraint(item: logoImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 44).isActive = true
        }
        NSLayoutConstraint(item: logoImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: logoImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.33, constant: 0).isActive = true
        NSLayoutConstraint(item: logoImageView, attribute: .height, relatedBy: .equal, toItem: logoImageView, attribute: .width, multiplier: 0.85, constant: 0).isActive = true
    }
    
    private func addEmailTextField() {
        addSubview(emailTextField)
        NSLayoutConstraint(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: logoImageView, attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
        NSLayoutConstraint(item: emailTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: emailTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: emailTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0).isActive = true
        
        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        NSLayoutConstraint(item: lineView, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: lineView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: lineView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: lineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.5).isActive = true
    }
    
    private func addPasswordTextField() {
        addSubview(passwordTextField)
        NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0).isActive = true
        
        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        NSLayoutConstraint(item: lineView, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: lineView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: lineView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: lineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.5).isActive = true
    }
    
    private func addForgotPasswordButton() {
        addSubview(forgotPasswordButton)
        if #available(iOS 11.0, *), DeviceType.hasTopNotch {
            NSLayoutConstraint(item: forgotPasswordButton, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        }
        else {
            NSLayoutConstraint(item: forgotPasswordButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -16).isActive = true
        }
        NSLayoutConstraint(item: forgotPasswordButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: forgotPasswordButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: forgotPasswordButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0).isActive = true
    }
    
    @objc private func forgotButtonTapped(_ sender: UIButton) {
        didPressForgotPasswordButton?()
    }
    
    private func addSignInButton() {
        addSubview(signInButton)
        NSLayoutConstraint(item: signInButton, attribute: .bottom, relatedBy: .equal, toItem: forgotPasswordButton, attribute: .top, multiplier: 1.0, constant: -8).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 54.0).isActive = true
    }
    
    @objc private func signInButtonTapped(_ sender: UIButton) {
        didPressSignInButton?()
    }
}

// MARK: UITextField Delegate

extension SignInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

// MARK: SignInView public methods

extension SignInView {
    func getEmailText() -> String? {
        return emailTextField.text
    }
    
    func getPasswordText() -> String? {
        return passwordTextField.text
    }
    
    func setEmailText(_ value: String) {
        emailTextField.text = value
    }
    
    func setPasswordText(_ value: String) {
        passwordTextField.text = value
    }
}

