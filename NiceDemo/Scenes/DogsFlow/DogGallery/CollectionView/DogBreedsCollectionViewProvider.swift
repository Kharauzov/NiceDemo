//
//  DogBreedsCollectionViewProvider.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 1/5/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

class DogBreedsCollectionViewProvider: NSObject, CollectionViewProvider {
    
    var data = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogBreedCollectionViewCell.reuseIdentifier, for: indexPath) as! DogBreedCollectionViewCell
        cell.setTitle(data[indexPath.row])
        return cell
    }
}
