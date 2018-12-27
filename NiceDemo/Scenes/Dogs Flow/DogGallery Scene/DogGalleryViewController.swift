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
        navigationItem.title = "Dog gallery"
        subscribeOnCustomViewActions()
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
}

// MARK: DogGalleryViewInterface

extension DogGalleryViewController: DogGalleryViewInterface {
    func setDogImage(_ image: UIImage) {
        customView.setDogImage(image)
    }
    
    func setDogBreed(_ breed: String) {
        customView.setDogBreed(breed)
    }
    
    func showHUD(animated: Bool) {
        customView.showHUD(animated: animated)
    }
    
    func hideHUD(animated: Bool) {
        customView.hideHUD(animated: animated)
    }
}
