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
    func showHUDAt(view: UIView, animated: Bool)
    func hideHUD(hud: HUDView, animated: Bool)
}

extension HUDDisplayable {
    func showHUDAt(view: UIView, animated: Bool) {
        let hudView = HUDView(frame: .zero)
        view.addSubview(hudView)
        pinEdgesOf(hudView, to: view)
        if animated {
            hudView.startAnimating()
            UIView.animate(withDuration: 1, animations: {
                hudView.alpha = 1
            })
        } else {
            hudView.alpha = 1
        }
    }
    
    func hideHUD(hud: HUDView, animated: Bool) {
        if animated {
            hud.stopAnimating()
            UIView.animate(withDuration: 1, animations: {
                hud.alpha = 0
            }, completion: { (completed) in
                hud.removeFromSuperview()
            })
        } else {
            hud.alpha = 0
        }
    }
    
    private func pinEdgesOf(_ view: UIView, to superView: UIView) {
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true   
    }
}


