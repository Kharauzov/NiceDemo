//
//  DogsListContract.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol DogsListViewInterface: class {
    func reloadData()
    func setTableViewProvider(_ provider: TableViewProvider)
    func showAlert(title: String?, message: String?)
    func showHUD(animated: Bool)
    func hideHUD(animated: Bool)
}

protocol DogsListPresentation: class {
    func onViewDidLoad()
}
