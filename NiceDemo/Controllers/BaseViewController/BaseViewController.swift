//
//  BaseViewController.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/4/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        debugPrint("\(#function) at \(self)")
    }
    
    // MARK: Public methods
    
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
