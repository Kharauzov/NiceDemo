//
//  GetAllDogsServerResponse.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/13/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

class GetAllDogsServerResponse: BaseResponse {
    var formattedData: [Dog]? {
        guard let data = data else { return nil }
        var dogs = [Dog]()
        data.forEach({ (item) in
            dogs.append(Dog(breed: item.key, subbreeds: item.value))
        })
        return dogs
    }
    
    private let data: [String: [String]]?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try values.decode([String: [String]].self, forKey: .data)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
    }
}


extension GetAllDogsServerResponse {
    enum CodingKeys: String, CodingKey {
        case data = "message"
        //case formattedData
        //case someString
    }
}
