//
//  HUDDisplayable.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/19/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

/// Displays animating HUD above `UIView`.
protocol HUDDisplayable {
    func showHUD(animated: Bool)
    func showHUD(backgroundColor: UIColor?, tintColor: UIColor?, animated: Bool)
    func hideHUD(animated: Bool)
}

extension HUDDisplayable where Self: UIView {
    func showHUD(animated: Bool) {
        showHUD(backgroundColor: nil, tintColor: nil, animated: animated)
    }
    
    func showHUD(backgroundColor: UIColor?, tintColor: UIColor?, animated: Bool) {
        // check, if view has presented `HUD` already.
        // to avoid dublication of `HUD`
        guard HUDView.hudIn(view: self) == nil else { return }
        let hudView = HUDView(frame: .zero, backgroundColor: backgroundColor, tintColor: tintColor)
        addSubview(hudView)
        pinEdgesOf(hudView, to: self)
        hudView.startAnimating()
        if animated {
            UIView.animate(withDuration: 1, animations: {
                hudView.alpha = 1
            })
        } else {
            hudView.alpha = 1
        }
    }
    
    func hideHUD(animated: Bool) {
        // check, if view has presented `HUD` already.
        // to have `HUD` for hiding..
        guard let hud = HUDView.hudIn(view: self) else { return }
        hud.stopAnimating()
        if animated {
            UIView.animate(withDuration: 1, animations: {
                hud.alpha = 0
            }, completion: { (completed) in
                hud.removeFromSuperview()
            })
        } else {
            hud.removeFromSuperview()
        }
    }
    
    private func pinEdgesOf(_ view: UIView, to superView: UIView) {
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true   
    }
}


