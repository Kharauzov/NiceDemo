//
//  GetRandomDogImageServerResponse.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

class GetRandomDogImageServerResponse: BaseResponse {
    var data: String?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decode(String.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
    }
}

extension GetRandomDogImageServerResponse {
    enum CodingKeys: String, CodingKey {
        case data = "message"
    }
}
