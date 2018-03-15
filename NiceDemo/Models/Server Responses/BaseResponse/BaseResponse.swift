//
//  BaseResponse.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/13/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

class BaseResponse: Codable {
    let status: String
    let error: String?
}
