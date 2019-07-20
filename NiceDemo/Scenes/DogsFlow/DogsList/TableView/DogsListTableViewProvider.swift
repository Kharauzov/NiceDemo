//
//  DogsListTableViewProvider.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class DogsListTableViewProvider: NSObject, TableViewProvider {
    
    // MARK: Properties
    
    var data = [Dog]()
    var didSelectItem: ((_ atIndex: Int) -> Void)?
    private let dogDescriptionFormatter = DogDescriptionFormatter()
    
    // MARK: TableViewProvider methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DogBreedTableViewCell.reuseIdentifier, for: indexPath) as? DogBreedTableViewCell else {
            return UITableViewCell()
        }
        let description = dogDescriptionFormatter.getBreedDescriptionFrom(dog: data[indexPath.row])
        cell.setTitle(description.title, subtitle: description.subtitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectItem?(indexPath.row)
    }
}
