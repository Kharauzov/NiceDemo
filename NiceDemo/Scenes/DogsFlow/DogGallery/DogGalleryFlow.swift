//
//  DogGalleryFlow.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 1/17/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import UIKit

enum DogGalleryFlow {
    enum ViewState {
        case loadingRandomImage
        case resultRandomImage(UIImage)
        case errorGettingRandomImage(message: String)
    }
}
