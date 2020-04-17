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
        setupSearchController()
        setupNavigationItem()
        registerTableViewForForceTouchInteractions()
        showNavigationBar()
        presenter.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
    }
    
    // MARK: Public methods
    
    func setPresenter(_ presenter: DogsListPresentation) {
        self.presenter = presenter
    }
    
    func registerTableViewForForceTouchInteractions() {
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: customView.tableView)
        }
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupNavigatioBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupNavigationItem() {
        navigationItem.title = "List of dogs"
    }
    
    @objc func favouriteButtonTapped(_ sender: Any) {
        presenter.handleFavouriteButtonTap()
    }
}

extension DogsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.handleSearchBarTextChange(searchController.searchBar.text)
    }
}

extension DogsListViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let tableView = previewingContext.sourceView as? UITableView else {
            return nil
        }
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return nil
        }
        previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
        return presenter.getGalleryViewForItem(at: indexPath)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let viewController = (viewControllerToCommit as? UINavigationController)?.viewControllers[0] {
            navigationController?.pushViewController(viewController, animated: true)
        }
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
    
    func showFavouriteBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourite", style: .done, target: self, action: #selector(favouriteButtonTapped(_:)))
    }
    
    func hideFavouriteBarButton() {
        navigationItem.rightBarButtonItem = nil
    }
}
