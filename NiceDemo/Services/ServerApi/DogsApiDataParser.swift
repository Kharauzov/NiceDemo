//
//  DogsApiDataParser.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 18.04.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import Foundation

class DogsApiDataParser: DogsServerResponseParser {
    
    private let decoder = JSONDecoder()
    
    func parseGetAllDogsResponse(data: Data) -> [Dog]? {
        do {
            let parsedResponse = try decoder.decode(GetAllDogsServerResponse.self, from: data)
            return parsedResponse.formattedData
        } catch {
            return nil
        }
    }
    
    func parseGetDogRandomImageUrlResponse(data: Data) -> String? {
        do {
            let parsedResponse = try decoder.decode(GetRandomDogImageServerResponse.self, from: data)
            return parsedResponse.data
        } catch {
            return nil
        }
    }
}
