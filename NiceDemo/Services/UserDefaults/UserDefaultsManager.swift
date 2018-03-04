//
//  UserDefaultsManager.swift
//
//
//  Created by Serhii Kharauzov on 1/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

/// Wrapper, responsible for storing/retrieving data using UserDefaults.
class UserDefaultsManager {

    // MARK: Public Properties

    static let shared = UserDefaultsManager()
    
    var launchesCounter: Int {
        get {
            return defaults.integer(forKey: GeneralKeys.launchesCounter)
        } set {
            defaults.set(newValue, forKey: GeneralKeys.launchesCounter)
        }
    }
    
    // MARK: Private properties
    
    private let defaults = UserDefaults()
    
    // MARK: Init
    
    private init() {
    }
}

extension UserDefaultsManager {
    private struct GeneralKeys {
        static let launchesCounter = "launchesCounter"
    }
}
