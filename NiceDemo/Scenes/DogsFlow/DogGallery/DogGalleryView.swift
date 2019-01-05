//
//  DogGalleryView.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

class DogGalleryView: UIView {

    // MARK: Public properties
    
    var didPressActionButton: (() -> Void)?
    
    // MARK: Private properties
    
    private var dogBreedLabel: UILabel!
    private var dogImageView: UIImageView!
    private var actionButton: UIButton!
    private var shadowContainerView: UIView!
    private(set) var containerView: UIView!
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addShadowContainerView()
        addContainerView()
        addActionButton()
        addDogImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func addShadowContainerView() {
        shadowContainerView = UIView()
        shadowContainerView.translatesAutoresizingMaskIntoConstraints = false
        shadowContainerView.backgroundColor = .clear
        shadowContainerView.addSketchShadow(color: UIColor.AppColors.primaryColor, alpha: 0.28, x: 0, y: 6, blur: 16, spread: 0)
        addSubview(shadowContainerView)
        if #available(iOS 11.0, *), DeviceType.hasTopNotch {
            NSLayoutConstraint(item: shadowContainerView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 24).isActive = true
            NSLayoutConstraint(item: shadowContainerView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -24).isActive = true
        } else {
            NSLayoutConstraint(item: shadowContainerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 24).isActive = true
            NSLayoutConstraint(item: shadowContainerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -24).isActive = true
        }
        NSLayoutConstraint(item: shadowContainerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: shadowContainerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16).isActive = true
    }
    
    private func addContainerView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 14
        shadowContainerView.addSubview(containerView)
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: shadowContainerView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: shadowContainerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: shadowContainerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: shadowContainerView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func addDogBreedLabel() {
        dogBreedLabel = UILabel(frame: .zero)
        dogBreedLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        dogBreedLabel.textAlignment = .center
        dogBreedLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dogBreedLabel)
        NSLayoutConstraint(item: dogBreedLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 24).isActive = true
        NSLayoutConstraint(item: dogBreedLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: dogBreedLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16).isActive = true
    }
    
    private func addDogImageView() {
        dogImageView = UIImageView(frame: .zero)
        dogImageView.contentMode = .scaleAspectFill
        dogImageView.clipsToBounds = true
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dogImageView)
        NSLayoutConstraint(item: dogImageView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func addActionButton() {
        actionButton = UIButton(type: .roundedRect)
        actionButton.setTitle("Next image", for: .normal)
        actionButton.setTitleColor(UIColor.AppColors.secondaryColor, for: .normal)
        actionButton.layer.cornerRadius = 10.0
        actionButton.backgroundColor = UIColor.AppColors.primaryColor
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(actionButton)
        NSLayoutConstraint(item: actionButton, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: actionButton, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: actionButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 54.0).isActive = true
        NSLayoutConstraint(item: actionButton, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: -16).isActive = true
    }
    
    @objc private func actionButtonTapped(_ sender: UIButton) {
        didPressActionButton?()
    }
}

// MARK: Public methods

extension DogGalleryView {
    func setDogImage(_ image: UIImage) {
        dogImageView.image = image
    }
    
    func setDogBreed(_ breed: String) {
        dogBreedLabel.text = breed
    }
}
