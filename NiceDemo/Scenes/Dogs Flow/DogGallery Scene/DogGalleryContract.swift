//
//  DogGalleryContract.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol DogGalleryViewInterface: class {
    func setDogImage(_ image: UIImage)
    func setDogBreed(_ breed: String)
}

protocol DogGalleryPresentation: class {
    func onViewDidLoad()
    func handleActionButtonTap()
}
