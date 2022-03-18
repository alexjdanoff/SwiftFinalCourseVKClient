//
//  CustomTableViewCell.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 22.11.2021.
//

import UIKit

class CustomTableViewCellGroups: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tealView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    var clusure: (() -> Void)?
    var isButtonPressed = false
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarComfigure()
        isButtonPressed = false
    }
    
    func configure(group: Group, clusure: @escaping (() -> Void)) {
        if let imageName = group.avatar {
            avatarImageView.image = UIImage(named: imageName)
        }
        
        nameLabel.text = group.name
        self.clusure = clusure
        
    }
    
    func avatarComfigure() {
        avatarImageView.layer.cornerRadius = tealView.frame.size.height / 2
        tealView.layer.cornerRadius = tealView.frame.size.height / 2
        
        tealView.layer.shadowColor = UIColor.black.cgColor
        tealView.layer.shadowOffset = CGSize(width: 5, height: 5)
        tealView.layer.shadowRadius = 7
        tealView.layer.shadowOpacity = 0.5
    }
    
    
    @IBAction func pressAddButton(_ sender: UIButton) {
        self.clusure?()
        
        UIView.transition(with: addButton,
                          duration: 0.7,
                          options: .transitionFlipFromTop) {[weak self] in
            self?.addButton.setImage(UIImage(named: "ceckicon2"), for: .normal)
        }
        
    }
    
}

