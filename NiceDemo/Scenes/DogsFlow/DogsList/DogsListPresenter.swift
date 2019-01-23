//
//  DogsListPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class DogsListPresenter {

    // MARK: Properties
    
    weak var delegate: DogsListSceneDelegate?
    weak var view: DogsListViewInterface!
    let serverService: DogsListServerProtocol
    let storageService: DogsListStorageProtocol
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
            updateFavouriteButtonVisibility(hasFavouriteDog: isFavouriteDogAvailable)
        }
    }
    var isFavouriteDogAvailable: Bool {
        return getFavouriteDog() != nil
    }
    var state = DogsListFlow.ViewState.loading {
        didSet {
            updateViewBasedOn(state: state)
        }
    }
    
    // MARK: Public methods
    
    init(view: DogsListViewInterface, serverService: DogsListServerProtocol = DogsServerService(), storageService: DogsListStorageProtocol = DogsStorageService()) {
        self.view = view
        self.serverService = serverService
        self.storageService = storageService
    }
    
    func fetchListOfDogs() {
        serverService.getAllDogs { [weak self] (data, error) in
            guard let self = self else { return }
            if let data = data {
                self.state = .result(data)
            } else if let error = error {
                self.state = .error(message: error.localizedDescription)
            }
        }
    }
    
    func getFavouriteDog() -> Dog? {
        guard let breed = storageService.getFavouriteDogBreed() else {
            return nil
        }
        return fetchedData.filter({$0.breed == breed}).first
    }
    
    func updateFavouriteButtonVisibility(hasFavouriteDog: Bool) {
        if hasFavouriteDog {
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
        updateFavouriteButtonVisibility(hasFavouriteDog: isFavouriteDogAvailable)
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
