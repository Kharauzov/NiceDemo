//
//  DogsListTableViewProvider.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol DogsListTableViewProviderDelegate: TableViewProviderDelegate {
    func getFormattedDescriptionForItem(at index: Int) -> String
}

class DogsListTableViewProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    private var dataItems = [Dog]()
    weak var delegate: DogsListTableViewProviderDelegate?
    
    // MARK: UITableView DataSource + Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DogBreedTableViewCell.reuseIdentifier, for: indexPath) as! DogBreedTableViewCell
        let description = delegate?.getFormattedDescriptionForItem(at: indexPath.row) ?? ""
        cell.setDogDescription(value: description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension DogsListTableViewProvider {
    func setData(_ data: [Dog]) {
        dataItems = data
    }
}
