//
//  LoadViewURL.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 28.12.2021.
//

import UIKit

// загурзка картинок по урлу
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
