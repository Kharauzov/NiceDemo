//
//  ServerService.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

typealias ServerRequestResponseCompletion<T> = (Result<T>) -> Void

protocol ServerService {
    func performRequest<T>(_ request: URLRequestable, completion: ServerRequestResponseCompletion<T>?)
}
