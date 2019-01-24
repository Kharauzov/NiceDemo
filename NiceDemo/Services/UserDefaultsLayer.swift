//
//  UserDefaultsLayer.swift
//
//
//  Created by Serhii Kharauzov on 1/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

/// Wrapper, responsible for storing/retrieving data using UserDefaults.
///
/// You shouldn't call its properties explicitly! Please use it as an abstract layer in
/// storage services via protocols.
class UserDefaultsLayer: UserCredentialsStorage, DogsStorage {

    init(userDefaultsSuiteName: String? = nil) {
        defaults = UserDefaults(suiteName: userDefaultsSuiteName)!
    }
    
    // MARK: Public Properties
    
    var isUserAuthenticated: Bool {
        get {
            return defaults.bool(forKey: GeneralKeys.isUserAuthenticated)
        } set {
            defaults.set(newValue, forKey: GeneralKeys.isUserAuthenticated)
        }
    }
    
    var favouriteDogBreed: String? {
        get {
            return defaults.string(forKey: GeneralKeys.favouriteDogBreed)
        } set {
            defaults.set(newValue, forKey: GeneralKeys.favouriteDogBreed)
        }
    }
    
    // MARK: Private properties
    
    private let defaults: UserDefaults
}

extension UserDefaultsLayer {
    private struct GeneralKeys {
        static let isUserAuthenticated = "isUserAuthenticated"
        static let favouriteDogBreed = "favouriteDogBreed"
    }
}
