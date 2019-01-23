 //
//  DogsServerService.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/13/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
 
extension DogsServerService: DogGalleryServerProtocol, DogsListServerProtocol {}
 
 /// Responsible for performing network requests relating to Dogs.
 ///
 /// We used *core* property, that is abstract class for any network manager, that could
 /// be used for implementing network requests. One can replace it on any class, that implements
 /// **ServerService** protocol. For now we use `UrlSession` as a simple example, but
 /// it can be easily replaced on `Alamofire`, `AFNetworking`, etc.
class DogsServerService {
    
    // MARK: Private properties
    
    private let core: ServerService
    private let decoder: JSONDecoder
    
    // MARK: Public methods
    
    init(core: ServerService = UrlSessionService(), decoder: JSONDecoder = JSONDecoder()) {
        self.core = core
        self.decoder = decoder
    }
    
    func getAllDogs(completion: @escaping ([Dog]?, Error?) -> Void) {
        core.performRequest(ServerRouter.getAllDogsBreeds) { (result: Result<Data>) in
            switch result {
            case .success(let data):
                completion(self.parseGetAllDogsResponse(data: data), nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getDogRandomImageUrl(breed: String, completion: @escaping (String?, Error?) -> Void) {
        core.performRequest(ServerRouter.getDogRandomImage(breed)) { (result: Result<Data>) in
            switch result {
            case .success(let data):
                completion(self.parseGetDogRandomImageUrlResponse(data: data), nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // MARK: Private methods
    
    private func parseGetAllDogsResponse(data: Data) -> [Dog]? {
        do {
            let parsedResponse = try decoder.decode(GetAllDogsServerResponse.self, from: data)
            return parsedResponse.formattedData
        } catch {
            return nil
        }
    }
    
    private func parseGetDogRandomImageUrlResponse(data: Data) -> String? {
        do {
            let parsedResponse = try decoder.decode(GetRandomDogImageServerResponse.self, from: data)
            return parsedResponse.data
        } catch {
            return nil
        }
    }
}
