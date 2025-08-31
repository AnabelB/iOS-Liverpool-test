//
//  UIImageView+Extension.swift
//  iOS-Project
//
//  Created by Ana Bernal on 30/08/25.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(from urlString: String) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        self.image = UIImage(named: "searchIcon")
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image: UIImage = UIImage(data: data) {
                imageCache.setObject(image, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    self?.image = image
                }
            } else {
                print("Error to obtain image...")
            }
        }
    }
}
