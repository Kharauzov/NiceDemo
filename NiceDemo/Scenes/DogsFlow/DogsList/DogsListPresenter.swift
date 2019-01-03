//
//  DogsListPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol DogsListSceneDelegate: class {
    func didSelectDog(_ dog: Dog)
    func getGalleryView(for dog: Dog) -> UIViewController
}

class DogsListPresenter {

    // MARK: Public properties
    
    weak var delegate: DogsListSceneDelegate?
    weak var view: DogsListViewInterface!
    let dogsServerService = DogsServerService(core: UrlSessionService())
    let dogsStorageService = DogsStorageService(storage: UserDefaultsLayer())
    lazy var tableViewProvider: DogsListTableViewProvider = {
        let tableViewProvider = DogsListTableViewProvider()
        tableViewProvider.didSelectItem = { [unowned self] (atIndex: Int) in
            let dog = tableViewProvider.data[atIndex]
            self.delegate?.didSelectDog(dog)
        }
        return tableViewProvider
    }()
    var data: [Dog] {
        return tableViewProvider.data
    }
    
    // MARK: Public methods
    
    init(view: DogsListViewInterface) {
        self.view = view
    }
    
    func fetchListOfDogs(completion: @escaping (_ data: [Dog]) -> Void) {
        view.showHUD(animated: true)
        dogsServerService.getAllDogs { [weak self] (data, error) in
            self?.view.hideHUD(animated: true)
            if let data = data {
                completion(data)
            } else if let error = error {
                self?.view.showAlert(title: nil, message: error.localizedDescription)
            }
        }
    }
    
    func handleListOfDogsFetchResult(data: [Dog]) {
        tableViewProvider.data = data
        view.reloadData()
    }
    
    func getFavouriteDogBreed() -> String? {
        return dogsStorageService.favouriteDogBreed
    }
}

// MARK: DogsListPresentation Protocol

extension DogsListPresenter: DogsListPresentation {
    func onViewDidLoad() {
        view.setTableViewProvider(tableViewProvider)
        fetchListOfDogs { [weak self] (data) in
            self?.handleListOfDogsFetchResult(data: data)
        }
    }
    
    func onViewWillAppear() {
        if let _ = getFavouriteDogBreed() {
            view.showFavouriteBarButton()
        } else {
            view.hideFavouriteBarButton()
        }
    }
    
    func handleFavouriteButtonTap() {
        guard let breed = getFavouriteDogBreed() else {
            return
        }
        guard let dog = data.filter({$0.breed == breed}).first else {
            return
        }
        delegate?.didSelectDog(dog)
    }
    
    func getGalleryViewForItem(at indexPath: IndexPath) -> UIViewController? {
        let dog = tableViewProvider.data[indexPath.row]
        return delegate?.getGalleryView(for: dog)
    }
}
