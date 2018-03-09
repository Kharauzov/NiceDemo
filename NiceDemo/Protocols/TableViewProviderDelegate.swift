//
//  TableViewProviderDelegate.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol TableViewProviderDelegate: class {
    func didSelectItem(at index: Int)
}
