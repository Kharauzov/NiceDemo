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
class UserDefaultsLayer: UserCredentialsStorage {

    // MARK: Public Properties
    
    var launchesCounter: Int {
        get {
            return defaults.integer(forKey: GeneralKeys.launchesCounter)
        } set {
            defaults.set(newValue, forKey: GeneralKeys.launchesCounter)
        }
    }
    
    var isUserAuthenticated: Bool {
        get {
            return defaults.bool(forKey: GeneralKeys.isUserAuthenticated)
        } set {
            defaults.set(newValue, forKey: GeneralKeys.isUserAuthenticated)
        }
    }
    
    var favouriteDogName: String? {
        get {
            return defaults.string(forKey: GeneralKeys.favouriteDogName)
        } set {
            defaults.set(newValue, forKey: GeneralKeys.favouriteDogName)
        }
    }
    
    // MARK: Private properties
    
    private let defaults = UserDefaults()
}

extension UserDefaultsLayer {
    private struct GeneralKeys {
        static let launchesCounter = "launchesCounter"
        static let isUserAuthenticated = "isUserAuthenticated"
        static let favouriteDogName = "favouriteDogName"
    }
}
