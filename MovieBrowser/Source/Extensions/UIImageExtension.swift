//
//  UIImageExtension.swift
//  MovieBrowser
//
//  Created by Addin Gama Bertaqwa on 30/03/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

// Create a separate extension file
extension UIImageView {
    func loadFrom(URLAddress: String) {
            guard let url = URL(string: URLAddress) else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                if let imageData = try? Data(contentsOf: url) {
                    if let loadedImage = UIImage(data: imageData) {
                            self?.image = loadedImage
                    }
                }
            }
        }
}
