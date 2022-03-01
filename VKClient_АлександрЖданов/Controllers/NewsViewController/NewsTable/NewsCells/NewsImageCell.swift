//
//  NewsImageTableViewCell.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 03.02.2022.
//

import UIKit

class NewsImageCell: UITableViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ news: News) {
        if let imageUrl = URL(string: news.photosURL?.first ?? "" ) {
            imageNews.load(url: imageUrl)
        }
    }
    
    func configure(_ image: UIImage?) {
        imageNews.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageNews.contentMode = .scaleAspectFill

    }
    
}
