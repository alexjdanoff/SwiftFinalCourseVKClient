//
//  NewsTitleTableViewCell.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 03.02.2022.
//

import UIKit

class NewsTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tealView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarComfigure()
        dateConfigure()
    }
    
    func configure(_ news: News) {
        titleLabel.text = news.name
        dateLabel.text = news.date
        if let avatarUrl = URL(string: news.avatar) {
            avatarImageView.load(url: avatarUrl)
        }
    }
    
    func avatarComfigure() {
        avatarImageView.layer.cornerRadius = tealView.frame.size.height / 2
        tealView.layer.cornerRadius = tealView.frame.size.height / 2

    }
    
    func dateConfigure() {
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        dateLabel.textColor = UIColor.lightGray
    }

}
