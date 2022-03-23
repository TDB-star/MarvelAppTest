//
//  imageManager.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 21/03/2022.
//

import UIKit

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
//    func fetchImageData(from url: String) -> Data? {
//        guard let url = URL(string: url) else { return nil }
//        guard let imageData = try? Data(contentsOf: url) else {return nil}
//        return imageData
//    }
    
    func fetchImageDataToCache(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }
        .resume()
    }
}




class CustomImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = UIImage(systemName: "eye")
            return
        }
        // Taking the image from the cache
        
        if let cachedImage = getCachedImage(from: imageURL) {
            image = cachedImage
            return
        }
        // If there is no image, we download it from the network
        
        ImageManager.shared.fetchImageDataToCache(from: imageURL) { data, response in
            self.image = UIImage(data: data)
            
        // Save the image to the cache
            
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}

