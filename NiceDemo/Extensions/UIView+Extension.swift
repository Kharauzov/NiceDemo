//
//  UIView+Extensions.swift
//
//
//  Created by Serhii Kharauzov on 1/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

extension UIView: ReusableView {}

extension UIView: HUDDisplayable {
    func showHUD(animated: Bool) {
        // check, if view has presented `HUD` already.
        // to avoid dublication of `HUD`
        guard HUDView.hudIn(view: self) == nil else { return }
        showHUDAt(view: self, animated: animated)
    }
    
    func hideHUD(animated: Bool) {
        // check, if view has presented `HUD` already.
        // to have `HUD` for hiding..
        guard let hud = HUDView.hudIn(view: self) else { return }
        hideHUD(hud: hud, animated: animated)
    }
}
