//
//  DogGalleryContract.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol DogsGallerySceneDelegate: class {
}

protocol DogGalleryServerProtocol {
    func getDogRandomImageUrl(breed: String, completion: @escaping (String?, Error?) -> Void)
}

protocol DogGalleryStorageProtocol {
    func getFavouriteDogBreed() -> String?
    func setFavouriteDogBreed(_ breed: String?)
}

protocol DogGalleryViewInterface: class {
    func setDogImage(_ image: UIImage)
    func setNavigationTitle(_ title: String)
    func showHUD(animated: Bool)
    func hideHUD(animated: Bool)
    func setRightBarButtonItemHighlightState(_ isOn: Bool, animated: Bool)
    func setCollectionViewProvider(_ provider: CollectionViewProvider)
    func reloadCollectionView()
    func showNoDataLabel()    
    func hideNoDataLabel()
}

protocol DogGalleryPresentation: class {
    func onViewDidLoad()
    func handleActionButtonTap()
    func handleFavouriteButtonTap()
}
