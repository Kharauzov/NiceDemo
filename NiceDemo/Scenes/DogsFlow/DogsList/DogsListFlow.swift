//
//  DogsListFlow.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 1/16/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import Foundation

enum DogsListFlow {
    enum ViewState {
        case loading
        case result([Dog])
        case error(message: String)
    }
}
