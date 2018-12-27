//
//  DogsListPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol DogsListSceneDelegate: class {
    func didSelectDog(_ dog: Dog)
}

class DogsListPresenter {

    // MARK: Public properties
    
    weak var delegate: DogsListSceneDelegate?
    weak var view: DogsListViewInterface!
    let dogsServerService = DogsServerService(core: UrlSessionService())
    lazy var tableViewProvider: DogsListTableViewProvider = {
        let tableViewProvider = DogsListTableViewProvider()
        tableViewProvider.didSelectItem = { [unowned self] (atIndex: Int) in
            let dog = tableViewProvider.data[atIndex]
            self.delegate?.didSelectDog(dog)
        }
        return tableViewProvider
    }()
    
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
}

// MARK: DogsListPresentation Protocol

extension DogsListPresenter: DogsListPresentation {
    func onViewDidLoad() {
        view.setTableViewProvider(tableViewProvider)
        fetchListOfDogs { [weak self] (data) in
            self?.handleListOfDogsFetchResult(data: data)
        }
    }
}
