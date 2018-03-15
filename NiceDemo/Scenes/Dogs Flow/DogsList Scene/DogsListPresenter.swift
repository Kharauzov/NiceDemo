//
//  DogsListPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol DogsListSceneDelegate: class {
    
}

class DogsListPresenter {

    // MARK: Public properties
    
    weak var delegate: DogsListSceneDelegate?
    
    // MARK: Private properties

    private weak var view: DogsListViewInterface!
    private let dogsServerService = DogsServerService(core: UrlSessionService())
    private let tableViewProvicer = DogsListTableViewProvider()
    private var dogs = [Dog]()
    
    // MARK: Public methods
    
    init(view: DogsListViewInterface) {
        self.view = view
    }
    
    // MARK: Private methods
    
    private func fetchListOfDogs(completion: @escaping (_ data: [Dog]) -> Void) {
        dogsServerService.getAllDogs { [weak self] (data, error) in
            if let data = data {
                completion(data)
            } else if let error = error {
                self?.view.showAlert(title: nil, message: error.localizedDescription)
            }
        }
    }
    
    private func handleListOfDogsFetchResult(data: [Dog]) {
        dogs = data
        tableViewProvicer.setData(data)
        view.reloadData()
    }
    
    private func getFormattedDescriptionForDog(at index: Int) -> String {
        let dog = dogs[index]
        let dogBreed = dog.breed.uppercased()
        return "\(dogBreed)\n\n" + "Subreeds (\(dog.subbreeds.count))"
    }
}

extension DogsListPresenter: DogsListTableViewProviderDelegate {
    func didSelectItem(at index: Int) {
        // TODO: handle
    }
    
    func getFormattedDescriptionForItem(at index: Int) -> String {
        return getFormattedDescriptionForDog(at: index)
    }
}

// MARK: DogsListPresentation Protocol

extension DogsListPresenter: DogsListPresentation {
    func onViewDidLoad() {
        tableViewProvicer.delegate = self
        view.setTableViewProvider(tableViewProvicer)
        fetchListOfDogs { [weak self] (data) in
            self?.handleListOfDogsFetchResult(data: data)
        }
    }
}
