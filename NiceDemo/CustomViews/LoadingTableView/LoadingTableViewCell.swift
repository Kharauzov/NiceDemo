//
//  LoadingTableViewCell.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 1/16/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    let appearance = Appearance()
    lazy var avatarView = getConfiguredEmptyView(radius: appearance.avatarViewSize.width / 2)
    lazy var titleView = getConfiguredEmptyView(radius: appearance.titleCornerRadius)
    lazy var subtitleView = getConfiguredEmptyView(radius: appearance.titleCornerRadius)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialise() {
        selectionStyle = .none
        contentView.addSubview(avatarView)
        contentView.addSubview(titleView)
        contentView.addSubview(subtitleView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        // setting constraints for avatarView
        NSLayoutConstraint(item: avatarView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: avatarView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: avatarView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: avatarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: appearance.avatarViewSize.height).isActive = true
        NSLayoutConstraint(item: avatarView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: appearance.avatarViewSize.width).isActive = true
        // setting constraints for titleView
        NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint(item: titleView, attribute: .leading, relatedBy: .equal, toItem: avatarView, attribute: .trailing, multiplier: 1.0, constant: 12).isActive = true
        NSLayoutConstraint(item: titleView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: titleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: appearance.lineViewHeight).isActive = true
        // setting constraints for subtitleView
        NSLayoutConstraint(item: subtitleView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -15).isActive = true
        NSLayoutConstraint(item: subtitleView, attribute: .leading, relatedBy: .equal, toItem: avatarView, attribute: .trailing, multiplier: 1.0, constant: 12).isActive = true
        NSLayoutConstraint(item: subtitleView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: subtitleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: appearance.lineViewHeight).isActive = true
    }
    
    private func getConfiguredEmptyView(radius: CGFloat) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.primaryColor.withAlphaComponent(0.3)
        view.layer.cornerRadius = radius
        return view
    }
}

extension LoadingTableViewCell {
    struct Appearance {
        let avatarViewSize = CGSize(width: 50, height: 50)
        let lineViewHeight: CGFloat = 8
        let titleCornerRadius: CGFloat = 4
    }
}
