//
//  BaseNavigationController.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/4/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        removeBorder()
        makeNotTranslucent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        debugPrint("\(#function) at \(self)")
    }
    
    func makeNotTranslucent() {
        navigationBar.isTranslucent = false
    }
    
    func removeBorder() {
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.setValue(true, forKey: "hidesShadow")
    }
}
