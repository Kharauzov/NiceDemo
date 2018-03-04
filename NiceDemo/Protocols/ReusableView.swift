//
//  ReusableView.swift
//
//
//  Created by Serhii Kharauzov on 1/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

/// Object, that adopts this protocol, will use identifier that matches name of its class.
protocol ReusableView: class {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
