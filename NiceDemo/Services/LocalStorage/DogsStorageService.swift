//
//  DogsStorageService.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol DogsStorage {
    var favouriteDogBreed: String? { get set }
}

extension DogsStorageService: DogGalleryStorageProtocol, DogsListStorageProtocol {}

/// We used 'storage' property, that is abstract class for any data storage, that could
/// be used for setting/retrieving data. One can replace it on any class, that implements
/// 'DogsStorage' protocol. For now we use UserDefaults as a simple example, but
/// it can be easily replaced on SQLite, Realm, CoreData etc.
class DogsStorageService {
    
    private var storage: DogsStorage
    
    init(storage: DogsStorage = UserDefaultsLayer()) {
        self.storage = storage
    }
    
    // MARK: Public properties
    
    func getFavouriteDogBreed() -> String? {
        return storage.favouriteDogBreed
    }
    
    func setFavouriteDogBreed(_ breed: String?) {
        storage.favouriteDogBreed = breed
    }
}
