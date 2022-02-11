//
//  NewsImageTableViewCell.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 03.02.2022.
//

import UIKit

class NewsImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ news: News) {
        if let imageUrl = URL(string: news.image) {
            imageNews.load(url: imageUrl)
        }
    }
    
}
