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
    var imageLoadingDelayTask: DispatchWorkItem?
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
        initialiaseImageLoadingDelayTask()
        performRequestToGetRandomDogImage { [weak self] (urlString) in
            guard let self = self else { return }
            self.imageLoadingDelayTask?.cancel()
            self.imageLoader.loadImageFrom(urlString: urlString, completion: { [weak self] (image) in
                guard let self = self else { return }
                if let image = image {
                    self.state = .resultRandomImage(image)
                } else {
                    self.state = .errorGettingRandomImage(message: "Failed to load image from url")
                }
            })
        }
    }
    
    func initialiaseImageLoadingDelayTask() {
        imageLoadingDelayTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            self?.state = .loadingRandomImage
        }
        imageLoadingDelayTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task)
    }
    
    func isBreedFavourite() -> Bool {
        guard let favouriteBreed = storageService.getFavouriteDogBreed() else {
            return false
        }
        return favouriteBreed == dog.breed
    }
    
    func showDogSubbreeds(_ subbreeds: [String]) {
        view.setCollectionViewProvider(collectionViewProvider)
        collectionViewProvider.data = subbreeds.map({$0.capitalizingFirstLetter()})
        view.reloadCollectionView()
    }
    
    func updateDataLabelVisibility(hasSubbreeds: Bool) {
        if hasSubbreeds {
            view.hideNoDataLabel()
        } else {
            view.showNoDataLabel()
        }
    }
    
    func updateRightBarButtonItemHighlightState(_ highlighted: Bool) {
        view.setRightBarButtonItemHighlightState(highlighted, animated: true)
    }
    
    func updateViewBasedOn(state: DogGalleryFlow.ViewState) {
        switch state {
        case .loadingRandomImage:
            view.showHUD(animated: true)
        case .resultRandomImage(let image):
            view.hideHUD(animated: true)
            view.setDogImage(image, animated: true)
        case .errorGettingRandomImage(_):
            view.hideHUD(animated: true)
        }
    }
    
    func configureSubbreedsContent(basedOn subbreeds: [String]?) {
        if let subbreeds = subbreeds, !subbreeds.isEmpty {
            showDogSubbreeds(subbreeds)
            view.hideNoDataLabel()
        } else {
            view.showNoDataLabel()
        }
    }
}

// MARK: DogGalleryPresentation Protocol

extension DogGalleryPresenter: DogGalleryPresentation {
    func onViewDidLoad() {
        view.setNavigationTitle(dog.breed.capitalizingFirstLetter())
        updateRightBarButtonItemHighlightState(isBreedFavourite())
        configureSubbreedsContent(basedOn: dog.subbreeds)
        loadRandomDogImage()
    }
    
    func handleActionButtonTap() {
        loadRandomDogImage()
    }
    
    func handleFavouriteButtonTap() {
        let valueToStore = isBreedFavourite() ? nil : dog.breed
        storageService.setFavouriteDogBreed(valueToStore)
        updateRightBarButtonItemHighlightState(isBreedFavourite())
    }
}
