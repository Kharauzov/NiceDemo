//
//  SimpleImageLoader.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit


/// Responsible for retrieving UIImage via url using `Data.contentsOfUrl` method.
///
/// __DISCLAIMER__: This class was created just for demo purpose, where we need single loading at a time. It does not provide neither smart multi-loading nor caching.
///
/// Please use another services like Kingfisher, Haneke etc. for such purposes.

class SimpleImageLoader {
    func loadImageFrom(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let data = data {
                    completion(UIImage(data: data))
                } else {
                    completion(nil)
                }
            }
        }
    }
}
