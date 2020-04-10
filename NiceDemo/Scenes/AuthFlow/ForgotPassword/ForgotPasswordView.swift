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
    private var logoImageView: UIImageView!
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addLogoImageView()
        addEmailTextField()
        addDescriptionLabel()
        addForgotPasswordButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func addLogoImageView() {
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "walkingWithDog").withRenderingMode(.alwaysTemplate))
        logoImageView.tintColor = UIColor.AppColors.primaryColor
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView = logoImageView
        addSubview(logoImageView)
        NSLayoutConstraint(item: logoImageView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 44).isActive = true
        NSLayoutConstraint(item: logoImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: logoImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: logoImageView, attribute: .height, relatedBy: .equal, toItem: logoImageView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func addEmailTextField() {
        let emailTextField = UITextField(frame: .zero)
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.delegate = self
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.emailTextField = emailTextField
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
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor.AppColors.primaryColor
        descriptionLabel.textAlignment = .left
        descriptionLabel.text = "Enter your email and we’ll send you a link to get back to your account."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel = descriptionLabel
        addSubview(descriptionLabel)
        NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: emailTextField, attribute: .top, multiplier: 1.0, constant: -24).isActive = true
        NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
    }
    
    private func addForgotPasswordButton() {
        let submitButton = UIButton(type: .roundedRect)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.AppColors.secondaryColor, for: .normal)
        submitButton.layer.cornerRadius = 10.0
        submitButton.backgroundColor = UIColor.AppColors.primaryColor
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton = submitButton
        addSubview(submitButton)
        if DeviceType.hasTopNotch {
            NSLayoutConstraint(item: submitButton, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        } else {
            NSLayoutConstraint(item: submitButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -16).isActive = true
        }
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
