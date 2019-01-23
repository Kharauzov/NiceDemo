//
//  DogsListContract.swift
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

protocol DogsListServerProtocol {
    func getAllDogs(completion: @escaping ([Dog]?, Error?) -> Void)
}

protocol DogsListStorageProtocol {
    func getFavouriteDogBreed() -> String?
}

protocol DogsListViewInterface: class {
    func reloadData()
    func setTableViewProvider(_ provider: TableViewProvider)
    func showAlert(title: String?, message: String?)
    func showFavouriteBarButton()
    func hideFavouriteBarButton()
}

protocol DogsListPresentation: class {
    func onViewDidLoad()
    func onViewWillAppear()
    func getGalleryViewForItem(at indexPath: IndexPath) -> UIViewController?
    func handleFavouriteButtonTap()
    func handleSearchBarTextChange(_ text: String?)
}
