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
    
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var iconImageView: UIImageView!
    private var iconImageViewContainer: UIView!
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addIconImageView()
        addTitleLabel()
        addSubtitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            contentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        } else {
            contentView.backgroundColor = .clear
        }
    }
    
    // MARK: Private methods
    
    private func addIconImageView() {
        let size: CGFloat = 50
        iconImageViewContainer = UIView()
        iconImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        iconImageViewContainer.backgroundColor = UIColor.AppColors.primaryColor
        iconImageViewContainer.clipsToBounds = true
        iconImageViewContainer.layer.cornerRadius = size / 2
        contentView.addSubview(iconImageViewContainer)
        NSLayoutConstraint(item: iconImageViewContainer, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: iconImageViewContainer, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: iconImageViewContainer, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: iconImageViewContainer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size).isActive = true
        NSLayoutConstraint(item: iconImageViewContainer, attribute: .width, relatedBy: .equal, toItem: iconImageViewContainer, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        iconImageView = UIImageView(image: #imageLiteral(resourceName: "pawPrint").withRenderingMode(.alwaysTemplate))
        iconImageView.tintColor = UIColor.AppColors.secondaryColor
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.clipsToBounds = true
        iconImageViewContainer.addSubview(iconImageView)
        NSLayoutConstraint(item: iconImageView, attribute: .top, relatedBy: .equal, toItem: iconImageViewContainer, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: iconImageView, attribute: .leading, relatedBy: .equal, toItem: iconImageViewContainer, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: iconImageView, attribute: .bottom, relatedBy: .equal, toItem: iconImageViewContainer, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: iconImageView, attribute: .trailing, relatedBy: .equal, toItem: iconImageViewContainer, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
    }
    
    private func addTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        contentView.addSubview(titleLabel)
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: iconImageViewContainer, attribute: .trailing, multiplier: 1.0, constant: 12).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
    }
    
    private func addSubtitleLabel() {
        subtitleLabel = UILabel(frame: .zero)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        contentView.addSubview(subtitleLabel)
        NSLayoutConstraint(item: subtitleLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: subtitleLabel, attribute: .leading, relatedBy: .equal, toItem: iconImageViewContainer, attribute: .trailing, multiplier: 1.0, constant: 12).isActive = true
        NSLayoutConstraint(item: subtitleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
    }
}

// MARK: Public methods

extension DogBreedTableViewCell {
    func setTitle(_ title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
