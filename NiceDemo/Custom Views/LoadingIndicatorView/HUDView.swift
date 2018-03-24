//
//  LoadingIndicatorView.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/16/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

/// Responsible for showing dim view with loading activity indicator.

class HUDView: UIView {

    // MARK: Private properties
    
    private var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Init
    
    init(frame: CGRect, backgroundColor: UIColor?, tintColor: UIColor?) {
        super.init(frame: frame)
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
        addActivityIndicatorView()
        self.backgroundColor = backgroundColor ?? UIColor.black.withAlphaComponent(0.4)
        activityIndicatorView.color = tintColor ?? .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func addActivityIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(frame: .zero)
        activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: .width, relatedBy: .equal, toItem: activityIndicatorView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    }
}

// MARK: Public methods

extension HUDView {
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
    
    func isAnimating() -> Bool {
        return activityIndicatorView.isAnimating
    }
    
    /// Returns `HUDView` if it is subview of view. Else returns nil.
    static func hudIn(view: UIView) -> HUDView? {
        return view.subviews.filter({$0 is HUDView}).first as? HUDView
    }
}
