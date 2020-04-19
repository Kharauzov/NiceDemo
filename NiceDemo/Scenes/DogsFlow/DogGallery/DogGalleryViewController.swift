//
//  DogGalleryViewController.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class DogGalleryViewController: BaseViewController {
    
    // MARK: Properties

    var presenter: DogGalleryPresentation!
    lazy var customView = view as! DogGalleryView
    
    // MARK: Lifecycle

    override func loadView() {
        view = DogGalleryView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeOnCustomViewActions()
        setupNavigationItem()
        presenter.onViewDidLoad()
    }
    
    // MARK: Public methods
    
    func setPresenter(_ presenter: DogGalleryPresentation) {
        self.presenter = presenter
    }
    
    func subscribeOnCustomViewActions() {
        customView.didPressActionButton = { [unowned self] in
            self.presenter.handleActionButtonTap()
        }
    }
    
    func setupNavigationItem() {
        let rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "pawPrintNotSelected").withRenderingMode(.alwaysTemplate), landscapeImagePhone: nil, style: .done, target: self, action: #selector(favouriteButtonTapped))
        rightBarButtonItem.tintColor = UIColor.AppColors.primaryColor
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func favouriteButtonTapped() {
        presenter.handleFavouriteButtonTap()
    }
}

// MARK: DogGalleryViewInterface

extension DogGalleryViewController: DogGalleryViewInterface {
    func setCollectionViewProvider(_ provider: CollectionViewProvider) {
        customView.setCollectionViewProvider(provider)
    }
    
    func reloadCollectionView() {
        customView.reloadCollectionView()
    }
    
    func setDogImage(_ image: UIImage, animated: Bool) {
        customView.setDogImage(image, animated: animated)
    }
    
    func setNavigationTitle(_ title: String) {
        navigationItem.title = title
    }
    
    func showHUD(animated: Bool) {
        customView.containerView.showHUD(animated: animated)
    }
    
    func hideHUD(animated: Bool) {
        customView.containerView.hideHUD(animated: animated)
    }
    
    func setRightBarButtonItemHighlightState(_ isOn: Bool, animated: Bool) {
        guard let rightBarButtonItem = navigationItem.rightBarButtonItem else {
            return
        }
        rightBarButtonItem.image = (isOn ? #imageLiteral(resourceName: "pawPrintSelected") : #imageLiteral(resourceName: "pawPrintNotSelected")).withRenderingMode(.alwaysTemplate)
    }
    
    func showNoDataLabel() {
        customView.showNoDataLabel()
    }
    
    func hideNoDataLabel() {
        customView.hideNoDataLabel()
    }
}
