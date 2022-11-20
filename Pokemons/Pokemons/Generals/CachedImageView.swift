//
//  CachedImageView.swift
//  Pokemons
//
//  Created by Александра Захаревич on 20.11.22.
//

import UIKit

class CachedImageView: UIImageView {
    
    var imageURL: String?
    
    func load(url: String?) {
        imageURL = url
        guard let urlString = url, let url = URL(string: urlString) else {
            image = nil
            return
        }
        if let imageResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            image = UIImage(data: imageResponse.data)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, let response = response else { return }
                self?.saveImageInCache(response: response, data: data)
            }
        }.resume()
    }
    
    private func saveImageInCache(response: URLResponse, data: Data) {
        guard let url = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        
        if response.url?.absoluteString == imageURL {
            image = UIImage(data: data)
        }
    }
    
}
