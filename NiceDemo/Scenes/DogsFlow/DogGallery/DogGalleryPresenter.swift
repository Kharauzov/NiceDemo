//
//  DogGalleryPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class DogGalleryPresenter {
    
    // MARK: Properties
    
    weak var delegate: DogsGallerySceneDelegate?
    weak var view: DogGalleryViewInterface!
    let dog: Dog
    let serverService: DogGalleryServerProtocol
    let storageService: DogGalleryStorageProtocol
    let imageLoader: ImageLoader
    lazy var collectionViewProvider = DogBreedsCollectionViewProvider()
    var state = DogGalleryFlow.ViewState.loadingRandomImage {
        didSet {
            updateViewBasedOn(state: state)
        }
    }
    
    // MARK: Public methods
    
    init(view: DogGalleryViewInterface, dog: Dog, serverService: DogGalleryServerProtocol = DogsServerService(), storageService: DogGalleryStorageProtocol = DogsStorageService(), imageLoader: ImageLoader = SimpleImageLoader()) {
        self.view = view
        self.dog = dog
        self.serverService = serverService
        self.storageService = storageService
        self.imageLoader = imageLoader
    }
    
    func performRequestToGetRandomDogImage(completion: @escaping (_ url: String) -> Void) {
        serverService.getDogRandomImageUrl(breed: dog.breed) { [weak self] (urlString, error) in
            if let urlString = urlString {
                completion(urlString)
            } else if let error = error {
                self?.state = .errorGettingRandomImage(message: error.localizedDescription)
            }
        }
    }
    
    func loadRandomDogImage() {
        performRequestToGetRandomDogImage { [weak self] (urlString) in
            self?.imageLoader.loadImageFrom(urlString: urlString, completion: { [weak self] (image) in
                if let image = image {
                    self?.state = .resultRandomImage(image)
                } else {
                    self?.state = .errorGettingRandomImage(message: "Failed to load image from url")
                }
            })
        }
    }
    
    func isBreedFavourite() -> Bool {
        guard let favouriteBreed = storageService.getFavouriteDogBreed() else {
            return false
        }
        return favouriteBreed == dog.breed
    }
    
    func showDogSubbreeds() {
        if let subbreeds = dog.subbreeds, !subbreeds.isEmpty {
            view.setCollectionViewProvider(collectionViewProvider)
            collectionViewProvider.data = subbreeds.map({$0.capitalizingFirstLetter()})
            view.reloadCollectionView()
            view.hideNoDataLabel()
        } else {
            view.showNoDataLabel()
        }
    }
    
    func updateRightBarButtonItemHighlightState() {
        view.setRightBarButtonItemHighlightState(isBreedFavourite(), animated: true)
    }
    
    func updateViewBasedOn(state: DogGalleryFlow.ViewState) {
        switch state {
        case .loadingRandomImage:
            view.showHUD(animated: true)
            loadRandomDogImage()
        case .resultRandomImage(let image):
            view.hideHUD(animated: true)
            view.setDogImage(image)
        case .errorGettingRandomImage(_):
            view.hideHUD(animated: true)
        }
    }
}

// MARK: DogGalleryPresentation Protocol

extension DogGalleryPresenter: DogGalleryPresentation {
    func onViewDidLoad() {
        showDogSubbreeds()
        view.setNavigationTitle(dog.breed.capitalizingFirstLetter())
        updateRightBarButtonItemHighlightState()
        state = .loadingRandomImage
    }
    
    func handleActionButtonTap() {
        state = .loadingRandomImage
    }
    
    func handleFavouriteButtonTap() {
        let valueToStore = isBreedFavourite() ? nil : dog.breed
        storageService.setFavouriteDogBreed(valueToStore)
        updateRightBarButtonItemHighlightState()
    }
}
