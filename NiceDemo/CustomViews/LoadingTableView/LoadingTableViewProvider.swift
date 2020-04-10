//
//  LoadingTableViewProvider.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 1/16/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class LoadingTableViewProvider: NSObject, TableViewProvider {
    
    let configuration: Configuration
    
    init(configuration: Configuration = Configuration()) {
        self.configuration = configuration
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return configuration.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier, for: indexPath) as? LoadingTableViewCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return configuration.heightForRow
    }
}

extension LoadingTableViewProvider {
    struct Configuration {
        let numberOfSections: Int
        let numberOfRowsInSection: Int
        let heightForRow: CGFloat
        
        init(numberOfSections: Int = 1, numberOfRowsInSection: Int = 100, heightForRow: CGFloat = 70) {
            self.numberOfSections = numberOfSections
            self.numberOfRowsInSection = numberOfRowsInSection
            self.heightForRow = heightForRow
        }
    }
}
