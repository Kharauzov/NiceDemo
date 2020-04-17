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
    
    var data = [DogBreedViewModel]()
    var didSelectItem: ((_ atIndex: Int) -> Void)?
    
    // MARK: TableViewProvider methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DogBreedTableViewCell.reuseIdentifier, for: indexPath) as? DogBreedTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = data[indexPath.row]
        cell.setTitle(viewModel.title, subtitle: viewModel.subtitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectItem?(indexPath.row)
    }
}
