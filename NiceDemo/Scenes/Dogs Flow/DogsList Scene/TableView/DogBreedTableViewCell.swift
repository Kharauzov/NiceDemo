//
//  DogBreedTableViewCell.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

class DogBreedTableViewCell: UITableViewCell {

    // MARK: Private properties
    
    private var dogDescriptionLabel: UILabel!
    
    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addDogDescriptionLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func addDogDescriptionLabel() {
        dogDescriptionLabel = UILabel(frame: .zero)
        dogDescriptionLabel.numberOfLines = 0
        dogDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dogDescriptionLabel)
        NSLayoutConstraint(item: dogDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: dogDescriptionLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: dogDescriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: dogDescriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
    }
}

// MARK: Public methods

extension DogBreedTableViewCell {
    func setDogDescription(value: String) {
        dogDescriptionLabel.text = value
    }
    
    func getDogDescription() -> String? {
        return dogDescriptionLabel.text
    }
}
