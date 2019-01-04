//
//  DogsListContract.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol DogsListViewInterface: class {
    func reloadData()
    func setTableViewProvider(_ provider: TableViewProvider)
    func showAlert(title: String?, message: String?)
    func showHUD(animated: Bool)
    func hideHUD(animated: Bool)
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
