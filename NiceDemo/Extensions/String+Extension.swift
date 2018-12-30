//
//  String+Extension.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 12/29/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
