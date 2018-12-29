//
//  DogDescriptionFormatter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 12/27/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

struct DogDescriptionFormatter {
    func getBreedDescriptionFrom(dog: Dog) -> (title: String, subtitle: String) {
        let dogBreedTitle = dog.breed.uppercased()
        let dogSubreedSubtitle: String
        if let dogSubreeds = dog.subbreeds, !dogSubreeds.isEmpty {
            dogSubreedSubtitle = "Has subreeds: (\(dogSubreeds.count))"
        } else {
            dogSubreedSubtitle = "No subreeds"
        }
        return (dogBreedTitle, dogSubreedSubtitle)
    }
}
