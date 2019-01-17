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

    // MARK: Properties
    
    weak var delegate: DogsListSceneDelegate?
    weak var view: DogsListViewInterface!
    let dogsServerService = DogsServerService(core: UrlSessionService())
    let dogsStorageService = DogsStorageService(storage: UserDefaultsLayer())
    let loadingTableViewProvider = LoadingTableViewProvider()
    lazy var contentTableViewProvider: DogsListTableViewProvider = {
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
            updateFavouriteButtonVisibility()
        }
    }
    var state = DogsListFlow.ViewState.loading {
        didSet {
            updateViewBasedOn(state: state)
        }
    }
    
    // MARK: Public methods
    
    init(view: DogsListViewInterface) {
        self.view = view
    }
    
    func fetchListOfDogs() {
        dogsServerService.getAllDogs { [weak self] (data, error) in
            guard let self = self else { return }
            if let data = data {
                self.state = .result(data)
            } else if let error = error {
                self.state = .error(message: error.localizedDescription)
            }
        }
    }
    
    func getFavouriteDog() -> Dog? {
        guard let breed = dogsStorageService.favouriteDogBreed else {
            return nil
        }
        return fetchedData.filter({$0.breed == breed}).first
    }
    
    func updateFavouriteButtonVisibility() {
        if let _ = getFavouriteDog() {
            view.showFavouriteBarButton()
        } else {
            view.hideFavouriteBarButton()
        }
    }
    
    func setLoadingTableView() {
        view.setTableViewProvider(loadingTableViewProvider)
        view.reloadData()
    }
    
    func setContentTableView(data: [Dog]) {
        view.setTableViewProvider(contentTableViewProvider)
        updateContentDataInView(data: data)
    }
    
    func updateContentDataInView(data: [Dog]) {
        contentTableViewProvider.data = data
        view.reloadData()
    }
    
    func updateViewBasedOn(state: DogsListFlow.ViewState) {
        switch state {
        case .loading:
            setLoadingTableView()
            // adding delay due to imitation of heavy request
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.fetchListOfDogs()
            }
        case .result(let items):
            fetchedData = items
            setContentTableView(data: fetchedData)
        case .error(let message):
            view.showAlert(title: nil, message: message)
        }
    }
}

// MARK: DogsListPresentation Protocol

extension DogsListPresenter: DogsListPresentation {
    func onViewDidLoad() {
        state = .loading
    }
    
    func onViewWillAppear() {
        updateFavouriteButtonVisibility()
    }
    
    func handleFavouriteButtonTap() {
        if let dog = getFavouriteDog() {
            delegate?.didSelectDog(dog)
        }
    }
    
    func getGalleryViewForItem(at indexPath: IndexPath) -> UIViewController? {
        let dog = contentTableViewProvider.data[indexPath.row]
        return delegate?.getGalleryView(for: dog)
    }
    
    func handleSearchBarTextChange(_ text: String?) {
        guard let text = text, !text.isEmpty else {
            return updateContentDataInView(data: fetchedData)
        }
        let filteredData = fetchedData.filter({$0.breed.lowercased().hasPrefix(text.lowercased())})
        updateContentDataInView(data: filteredData)
    }
}
