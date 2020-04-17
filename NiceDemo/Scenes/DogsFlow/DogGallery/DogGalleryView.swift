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
    
    private var noDataLabel: UILabel!
    private var dogImageView: UIImageView!
    private var actionButton: UIButton!
    private var shadowContainerView: UIView!
    private var collectionView: UICollectionView!
    private(set) var containerView: UIView!
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addShadowContainerView()
        addContainerView()
        addActionButton()
        addDogImageView()
        addCollectionView()
        addNoDataLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func addShadowContainerView() {
        let shadowContainerView = UIView()
        shadowContainerView.translatesAutoresizingMaskIntoConstraints = false
        shadowContainerView.backgroundColor = .clear
        shadowContainerView.addSketchShadow(color: UIColor.AppColors.primaryColor, alpha: 0.28, x: 0, y: 6, blur: 16, spread: 0)
        self.shadowContainerView = shadowContainerView
        addSubview(shadowContainerView)
        NSLayoutConstraint(item: shadowContainerView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 24).isActive = true
        NSLayoutConstraint(item: shadowContainerView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -24).isActive = true
        NSLayoutConstraint(item: shadowContainerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: shadowContainerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -16).isActive = true
    }
    
    private func addContainerView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 14
        self.containerView = containerView
        shadowContainerView.addSubview(containerView)
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: shadowContainerView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: shadowContainerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: shadowContainerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: shadowContainerView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func addNoDataLabel() {
        let noDataLabel = UILabel(frame: .zero)
        noDataLabel.text = "Has no subbreeds"
        noDataLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        noDataLabel.textAlignment = .center
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noDataLabel = noDataLabel
        containerView.addSubview(noDataLabel)
        NSLayoutConstraint(item: noDataLabel, attribute: .centerX, relatedBy: .equal, toItem: collectionView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: noDataLabel, attribute: .centerY, relatedBy: .equal, toItem: collectionView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func addDogImageView() {
        let dogImageView = UIImageView(frame: .zero)
        dogImageView.contentMode = .scaleAspectFill
        dogImageView.clipsToBounds = true
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        self.dogImageView = dogImageView
        containerView.addSubview(dogImageView)
        NSLayoutConstraint(item: dogImageView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dogImageView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    private func addCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: DogBreedCollectionViewCell.height)
        collectionViewLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView = collectionView
        containerView.addSubview(collectionView)
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: dogImageView, attribute: .bottom, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: actionButton, attribute: .top, multiplier: 1.0, constant: -30).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: DogBreedCollectionViewCell.height).isActive = true
        // registering cells
        collectionView.register(DogBreedCollectionViewCell.self, forCellWithReuseIdentifier: DogBreedCollectionViewCell.reuseIdentifier)
    }
    
    private func addActionButton() {
        let actionButton = UIButton(type: .roundedRect)
        actionButton.setTitle("Next image", for: .normal)
        actionButton.setTitleColor(UIColor.AppColors.secondaryColor, for: .normal)
        actionButton.layer.cornerRadius = 10.0
        actionButton.backgroundColor = UIColor.AppColors.primaryColor
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionButton = actionButton
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
    func setCollectionViewProvider(_ provider: CollectionViewProvider) {
        collectionView.dataSource = provider
        collectionView.delegate = provider
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func setDogImage(_ image: UIImage, animated: Bool) {
        let duration: TimeInterval = animated ? 0.5 : 0
        UIView.transition(
            with: dogImageView, duration: duration, options: .transitionCrossDissolve,
            animations: {
                self.dogImageView.image = image
            },
            completion: nil)
    }
    
    func showNoDataLabel() {
        noDataLabel.isHidden = false
    }
    
    func hideNoDataLabel() {
        noDataLabel.isHidden = true
    }
}
