//
//  DogsListViewController.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class DogsListViewController: BaseViewController {
    
    // MARK: Properties

    var presenter: DogsListPresentation!
    lazy var customView = view as! DogsListView
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = DogsListView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "List of dogs"
        showNavigationBar()
        presenter.onViewDidLoad()
    }
    
    // MARK: Public methods
    
    func setPresenter(_ presenter: DogsListPresentation) {
        self.presenter = presenter
    }
}

// MARK: DogsListViewInterface

extension DogsListViewController: DogsListViewInterface {
    func reloadData() {
        customView.reloadDataInTableView()
    }
    
    func setTableViewProvider(_ provider: TableViewProvider) {
        customView.setTableViewProvider(provider)
    }
    
    func showAlert(title: String?, message: String?) {
        presentAlert(title: title, message: message)
    }
    
    func showHUD(animated: Bool) {
        customView.showHUD(animated: animated)
    }
    
    func hideHUD(animated: Bool) {
        customView.hideHUD(animated: animated)
    }
}
