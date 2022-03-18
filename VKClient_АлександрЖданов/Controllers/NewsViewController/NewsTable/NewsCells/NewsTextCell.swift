//
//  NewsTextTableViewCell.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 03.02.2022.
//

import UIKit

class NewsTextCell: UITableViewCell {
    
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    var isTextOpened = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ news: News) {
        newsTextLabel.text = news.text
        showMoreButton.isHidden = true
        let size = getLabelSize(text:  newsTextLabel.text ?? "", font:  newsTextLabel.font)
        
        if size.height > 200 {
            newsTextLabel.numberOfLines = 4
            showMoreButton.isHidden = false
        }
    }
    
    @IBAction func pressShowMoreButton(_ sender: UIButton) {
        if newsTextLabel.numberOfLines > 0 {
            newsTextLabel.numberOfLines = 0
            isTextOpened = true
            titleLabelFrame()
            showMoreButton.setTitle("Показать меньше...", for: .normal)
        } else {
            newsTextLabel.numberOfLines = 4
            isTextOpened = false
            titleLabelFrame()
            showMoreButton.setTitle("Показать полностью...", for: .normal)
        }
    }
    
    func getLabelSize(text: String, font: UIFont) -> CGSize {
         let maxWidth = self.bounds.width * 2

         let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)

         let rect = (text as NSString).boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

         let size = rect.size

         return CGSize(width: ceil(size.width), height: ceil(size.height))
     }

     func titleLabelFrame() {
         let labelSize = self.getLabelSize(text: newsTextLabel.text ?? "", font: newsTextLabel.font!)
         self.frame.size = labelSize
     }
}
