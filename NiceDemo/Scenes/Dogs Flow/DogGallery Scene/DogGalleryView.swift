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
    private var dogImageViewContainer: UIView!
    private var actionButton: UIButton!
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addDogBreedLabel()
        addActionButton()
        addDogImageViewContainer()
        addDogImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func addDogBreedLabel() {
        dogBreedLabel = UILabel(frame: .zero)
        dogBreedLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        dogBreedLabel.textAlignment = .center
        dogBreedLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dogBreedLabel)
        NSLayoutConstraint(item: dogBreedLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 24).isActive = true
        NSLayoutConstraint(item: dogBreedLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: dogBreedLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16).isActive = true
        NSLayoutConstraint(item: dogBreedLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func addDogImageViewContainer() {
        dogImageViewContainer = UIView(frame: .zero)
        dogImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dogImageViewContainer)
        NSLayoutConstraint(item: dogImageViewContainer, attribute: .top, relatedBy: .equal, toItem: dogBreedLabel, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageViewContainer, attribute: .bottom, relatedBy: .equal, toItem: actionButton, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageViewContainer, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageViewContainer, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func addDogImageView() {
        dogImageView = UIImageView(frame: .zero)
        dogImageView.contentMode = .scaleAspectFill
        dogImageView.clipsToBounds = true
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        dogImageViewContainer.addSubview(dogImageView)
        NSLayoutConstraint(item: dogImageView, attribute: .centerY, relatedBy: .equal, toItem: dogImageViewContainer, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageView, attribute: .leading, relatedBy: .equal, toItem: dogImageViewContainer, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageView, attribute: .trailing, relatedBy: .equal, toItem: dogImageViewContainer, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageView, attribute: .height, relatedBy: .equal, toItem: dogImageViewContainer, attribute: .height, multiplier: 0.85, constant: 0).isActive = true
    }
    
    private func addActionButton() {
        actionButton = UIButton(type: .roundedRect)
        actionButton.setTitle("Get another one", for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 10.0
        actionButton.backgroundColor = UIColor.darkGray
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
        NSLayoutConstraint(item: actionButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -16).isActive = true
        NSLayoutConstraint(item: actionButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16.0).isActive = true
        NSLayoutConstraint(item: actionButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16.0).isActive = true
        NSLayoutConstraint(item: actionButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 54.0).isActive = true
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
