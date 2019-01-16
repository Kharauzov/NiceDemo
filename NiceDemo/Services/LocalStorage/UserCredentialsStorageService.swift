//
//  UserCredentialsStorageService.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol UserCredentialsStorage {
    var isUserAuthenticated: Bool { get set }
}

/// Responsible for keeping user's credentials data.
/// If data supposed to be sensitive, please use Keychain for that.
/// We used 'storage' property, that is abstract class for any data storage, that could
/// be used for setting/retrieving data. One can replace it on any class, that implements
/// 'UserCredentialsStorage' protocol. For now we use UserDefaults as a simple example, but
/// it can be easily replaced on SQLite, Realm, CoreData etc.
class UserCredentialsStorageService {
    
    private var storage: UserCredentialsStorage
    
    init(storage: UserCredentialsStorage) {
        self.storage = storage
    }
    
    // MARK: Public properties
    
    var isUserAuthenticated: Bool {
        get {
            return storage.isUserAuthenticated
        } set {
            storage.isUserAuthenticated = newValue
        }
    }
}
