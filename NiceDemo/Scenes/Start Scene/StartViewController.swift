//
//  StartViewController.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class StartViewController: BaseViewController {
    
    // MARK: Private properties

    lazy var customView = view as! StartView
    private var presenter: StartPresentation!

    // MARK: Lifecycle
    
    override func loadView() {
        self.view = StartView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        presenter.onViewDidLoad()
    }

    // MARK: Public methods
    
    func setPresenter(_ presenter: StartPresentation) {
        self.presenter = presenter
    }
}

// MARK: StartView Protocol

extension StartViewController: StartViewInterface {
    func showLoading() {
        customView.startActivityIndicator()
    }
    
    func hideLoading() {
        customView.stopActivityIndicator()
    }
}
