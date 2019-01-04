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
    // data, fetched from server
    var fetchedData = [Dog]() {
        didSet {
            updateViewData(data: fetchedData)
            updateFavouriteButtonState()
        }
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
    
    func updateViewData(data: [Dog]) {
        tableViewProvider.data = data
        view.reloadData()
    }
    
    func getFavouriteDog() -> Dog? {
        guard let breed = dogsStorageService.favouriteDogBreed else {
            return nil
        }
        return fetchedData.filter({$0.breed == breed}).first
    }
    
    func updateFavouriteButtonState() {
        if let _ = getFavouriteDog() {
            view.showFavouriteBarButton()
        } else {
            view.hideFavouriteBarButton()
        }
    }
}

// MARK: DogsListPresentation Protocol

extension DogsListPresenter: DogsListPresentation {
    func onViewDidLoad() {
        view.setTableViewProvider(tableViewProvider)
        fetchListOfDogs { [weak self] (data) in
            self?.fetchedData = data
        }
    }
    
    func onViewWillAppear() {
        updateFavouriteButtonState()
    }
    
    func handleFavouriteButtonTap() {
        if let dog = getFavouriteDog() {
            delegate?.didSelectDog(dog)
        }
    }
    
    func getGalleryViewForItem(at indexPath: IndexPath) -> UIViewController? {
        let dog = tableViewProvider.data[indexPath.row]
        return delegate?.getGalleryView(for: dog)
    }
    
    func handleSearchBarTextChange(_ text: String?) {
        guard let text = text, !text.isEmpty else {
            return updateViewData(data: fetchedData)
        }
        let filteredData = fetchedData.filter({$0.breed.lowercased().hasPrefix(text.lowercased())})
        updateViewData(data: filteredData)
    }
}
