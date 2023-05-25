//
//  Downloader.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

class Downloader {
    
    static let shared = Downloader()
    
    private var imageCache: NSCache<NSString, UIImage>
    
    private init() {
        self.imageCache = NSCache<NSString, UIImage>()
    }
    
    
    func downloadImage(with urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        if let cachedImage = self.imageCache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: urlString as NSString)
                return image
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
}
