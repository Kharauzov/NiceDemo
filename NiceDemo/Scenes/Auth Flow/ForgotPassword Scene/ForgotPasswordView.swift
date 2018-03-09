//
//  ForgotPasswordView.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIView {

    // MARK: Public properties
    
    var didPressSubmitButton: (() -> Void)?
    
    // MARK: Private properties
    
    private var submitButton: UIButton!
    private var emailTextField: UITextField!
    private var descriptionLabel: UILabel!
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addEmailTextField()
        addDescriptionLabel()
        addForgotPasswordButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func addEmailTextField() {
        emailTextField = UITextField(frame: .zero)
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.delegate = self
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailTextField)
        NSLayoutConstraint(item: emailTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
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
    
    private func addDescriptionLabel() {
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .left
        descriptionLabel.text = "Enter your email and we’ll send you a link to get back to your account."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: emailTextField, attribute: .top, multiplier: 1.0, constant: -24).isActive = true
        NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
    }
    
    private func addForgotPasswordButton() {
        submitButton = UIButton(type: .roundedRect)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10.0
        submitButton.backgroundColor = UIColor.darkGray
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(submitButton)
        NSLayoutConstraint(item: submitButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -16).isActive = true
        NSLayoutConstraint(item: submitButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: submitButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: submitButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 54.0).isActive = true
    }
    
    @objc private func submitButtonTapped(_ sender: UIButton) {
        didPressSubmitButton?()
    }
}

// MARK: UITextField Delegate

extension ForgotPasswordView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

// MARK: ForgotPasswordView public methods

extension ForgotPasswordView {
    func getEmailText() -> String? {
        return emailTextField.text
    }
}
