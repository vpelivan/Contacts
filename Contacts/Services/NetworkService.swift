//
//  NetworkService.swift
//  Contacts
//
//  Created by Victor Pelivan on 26.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import Foundation
import UIKit
import SwiftHash

// MARK: - Using Singleton Pattern for creating a universal single API request manager
class NetworkService {
    static let shared = NetworkService() // First condition to perform singleton
    private var imageCache = NSCache<NSString, UIImage>() // Our cache for images

    private init () {} // Second condition to perform singleton
    
    //MARK: - Next method performs image load request in case if it is not cached already, and if it is cached, it just pulls it from cache. It also handles right status codes and errors
    public func getImage(from url: URL, completion: @escaping (UIImage?)->()) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                guard let response = (response as? HTTPURLResponse), (200...299).contains(response.statusCode), error == nil, let data = data, let image = UIImage(data: data) else {
                    print("Image Request Error")
                    completion(nil)
                    return
                }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }.resume()
        }
    }
}
