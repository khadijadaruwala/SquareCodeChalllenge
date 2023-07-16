//
//  ImageCacheManager.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-16.
//

import Foundation
import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    private var cache: NSCache<NSString, UIImage> = NSCache()
    
    private init() {}
    
    func loadImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        guard let imageURL = URL(string: url) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                let error = NSError(domain: "Invalid image data", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            self.cache.setObject(image, forKey: url as NSString)
            completion(.success(image))
        }.resume()
    }
}
