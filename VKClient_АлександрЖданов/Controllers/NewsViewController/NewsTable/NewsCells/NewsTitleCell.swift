//
//  NewsTitleTableViewCell.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 03.02.2022.
//

import UIKit

class NewsTitleCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarComfigure()
        dateConfigure()
    }
    
    func configure(_ news: News) {
        titleLabel.text = news.creatorName
        dateLabel.text = news.getStringDate()
    }
    
    func configure(_ image: UIImage?) {
        avatarImageView.image = image
    }
    
    func avatarComfigure() {
        avatarImageView.layer.cornerRadius = containerView.frame.size.height / 2
        containerView.layer.cornerRadius = containerView.frame.size.height / 2

    }
    
    func dateConfigure() {
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        dateLabel.textColor = UIColor.lightGray
    }

}
