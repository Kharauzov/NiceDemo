//
//  DogsListTableViewProvider.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class DogsListTableViewProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var dataItems = [Dog]()
    weak var delegate: TableViewProviderDelegate?
    
    // MARK: Init
    
    override init() {
        super.init()
    }
    
    // MARK: UITableView DataSource + Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DogBreedTableViewCell.reuseIdentifier, for: indexPath) as! DogBreedTableViewCell
        cell.setDogDescriptionValue("data")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row)
    }
}

extension DogsListTableViewProvider {
    func setData(_ data: [Dog]) {
        dataItems = data
    }
}
