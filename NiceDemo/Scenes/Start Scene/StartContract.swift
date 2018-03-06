//
//  StartContract.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol StartViewInterface: class {
    func showLoading()
    func hideLoading()
}

protocol StartPresentation: class {
    func onViewDidLoad()
}
