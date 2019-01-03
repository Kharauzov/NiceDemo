//
//  DogGalleryPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol DogsGallerySceneDelegate: class {
}

class DogGalleryPresenter {
    
    // MARK: Public properties
    
    weak var delegate: DogsGallerySceneDelegate?
    weak var view: DogGalleryViewInterface!
    let dog: Dog
    let dogsServerService = DogsServerService(core: UrlSessionService())
    let dogsStorageService = DogsStorageService(storage: UserDefaultsLayer())
    let imageLoader = SimpleImageLoader()
    
    // MARK: Public methods
    
    init(view: DogGalleryViewInterface, dog: Dog) {
        self.view = view
        self.dog = dog
    }
    
    func performRequestToGetRandomDogImage(completion: @escaping (_ url: String) -> Void) {
        dogsServerService.getDogRandomImageUrl(breed: dog.breed) { (urlString, error) in
            if let urlString = urlString {
                completion(urlString)
            } else if let _ = error {
                // show error message
            }
        }
    }
    
    func loadRandomDogImage() {
        view.showHUD(animated: true)
        performRequestToGetRandomDogImage { [weak self] (urlString) in
            self?.imageLoader.loadImageFrom(urlString: urlString, completion: { [weak self] (image) in
                if let image = image {
                    self?.view.hideHUD(animated: true)
                    self?.view.setDogImage(image)
                }
            })
        }
    }
    
    func isBreedFavourite() -> Bool {
        guard let favouriteBreed = dogsStorageService.favouriteDogBreed else {
            return false
        }
        return favouriteBreed == dog.breed
    }
}

// MARK: DogGalleryPresentation Protocol

extension DogGalleryPresenter: DogGalleryPresentation {
    func onViewDidLoad() {
        view.setNavigationTitle(dog.breed.capitalizingFirstLetter())
        view.setRightBarButtonItemHighlightState(isBreedFavourite(), animated: true)
        loadRandomDogImage()
    }
    
    func handleActionButtonTap() {
        loadRandomDogImage()
    }
    
    func handleFavouriteButtonTap() {
        if isBreedFavourite() {
            dogsStorageService.favouriteDogBreed = nil
        } else {
            dogsStorageService.favouriteDogBreed = dog.breed
        }
        view.setRightBarButtonItemHighlightState(isBreedFavourite(), animated: true)
    }
}
