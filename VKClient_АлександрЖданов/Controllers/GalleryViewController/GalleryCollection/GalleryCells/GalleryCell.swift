//
//  GalleryCell.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 25.11.2021.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var fotoImageView: UIImageView!
    
    var isHeartActive = false
    var countLike = 0
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(image: UIImage?, index: Int) {
        fotoImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
