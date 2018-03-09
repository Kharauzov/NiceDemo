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
    
    // MARK: Private properties

    private var presenter: DogsListPresentation!
    private lazy var customView = view as! DogsListView
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = DogsListView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "List of dogs"
        presenter.onViewDidLoad()
    }
    
    // MARK: Public methods
    
    func setPresenter(_ presenter: DogsListPresentation) {
        self.presenter = presenter
    }
    
    // MARK: Private methods
}

// MARK: DogsListView Protocol

extension DogsListViewController: DogsListViewInterface {
    func reloadData() {
        customView.reloadDataInTableView()
    }
    
    func setTableViewProvider(_ provider: DogsListTableViewProvider) {
        customView.setTableViewProvider(provider)
    }
}
