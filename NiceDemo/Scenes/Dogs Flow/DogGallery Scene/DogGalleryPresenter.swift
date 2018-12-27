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
    let breed: String
    let dogsServerService = DogsServerService(core: UrlSessionService())
    let imageLoader = SimpleImageLoader()
    
    // MARK: Public methods
    
    init(view: DogGalleryViewInterface, breed: String) {
        self.view = view
        self.breed = breed
    }
    
    func performRequestToGetRandomDogImage(completion: @escaping (_ url: String) -> Void) {
        dogsServerService.getDogRandomImageUrl(breed: breed) { (urlString, error) in
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
}

// MARK: DogGalleryPresentation Protocol

extension DogGalleryPresenter: DogGalleryPresentation {
    func onViewDidLoad() {
        view.setDogBreed(breed)
        loadRandomDogImage()
    }
    
    func handleActionButtonTap() {
        loadRandomDogImage()
    }
}
