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

/// We used 'storage' property, that is abstract class for any data storage, that could
/// be used for setting/retrieving data. One can replace it on any class, that implements
/// 'DogsStorage' protocol. For now we use UserDefaults as a simple example, but
/// it can be easily replaced on SQLite, Realm, CoreData etc.
class DogsStorageService {
    
    private var storage: DogsStorage
    
    init(storage: DogsStorage) {
        self.storage = storage
    }
    
    // MARK: Public properties
    
    var favouriteDogBreed: String? {
        get {
            return storage.favouriteDogBreed
        } set {
            storage.favouriteDogBreed = newValue
        }
    }
}
