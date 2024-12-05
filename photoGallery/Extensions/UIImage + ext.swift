//
//  UIImage + ext.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 03.12.2024.
//
import UIKit

extension UIImageView {
    
    func downloadImage(from url: URL, completion: @escaping () -> Void) {
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completion()
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                ImageCacheManager.shared.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    self?.image = image
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = UIImage(systemName: "photo.on.rectangle.angled")
                    completion()
                }
            }
        }
        task.resume()
    }
}


final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
}
