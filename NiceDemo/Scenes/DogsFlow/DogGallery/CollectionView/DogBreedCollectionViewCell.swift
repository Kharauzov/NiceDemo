//
//  DogBreedCollectionViewCell.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 1/5/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import UIKit

class DogBreedCollectionViewCell: UICollectionViewCell {
    
    // MARK: Private properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    // MARK: Private methods
    
    private func initialise() {
        contentView.addSubview(titleLabel)
        setupBorder()
        setupConstraints()
    }
    
    private func setupBorder() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
    
    private func setupConstraints() {
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: DogBreedCollectionViewCell.height).isActive = true
    }
}

extension DogBreedCollectionViewCell {
    static let height: CGFloat = 55.0
}
