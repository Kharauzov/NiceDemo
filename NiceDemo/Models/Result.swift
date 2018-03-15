//
//  Result.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/14/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

/// The result of response serialization.
enum Result<T> {
    case success(T)
    case failure(Error)
}
