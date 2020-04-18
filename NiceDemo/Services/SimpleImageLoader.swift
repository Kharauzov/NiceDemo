//
//  SimpleImageLoader.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/15/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

protocol ImageLoader {
    func loadImageFrom(urlString: String, completion: @escaping (UIImage?) -> Void)
}

protocol ImageLoaderCore {
    func getImageData(from url: URL, completion: @escaping (_ data: Data?) -> Void)
}

/// Responsible for retrieving UIImage via url using `Data.contentsOfUrl` method.
///
/// __DISCLAIMER__: This class was created just for demo purpose, where we need single loading at a time. It does not provide neither smart multi-loading nor caching.
///
/// Please use another services like Kingfisher, Haneke etc. for such purposes.
class SimpleImageLoader: ImageLoader {
    
    let core: ImageLoaderCore
    
    init(core: ImageLoaderCore = SimpleImageLoaderCore()) {
        self.core = core
    }
    
    func loadImageFrom(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        core.getImageData(from: url) { (data) in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }
    }
}

class SimpleImageLoaderCore: ImageLoaderCore {
    func getImageData(from url: URL, completion: @escaping (_ data: Data?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
