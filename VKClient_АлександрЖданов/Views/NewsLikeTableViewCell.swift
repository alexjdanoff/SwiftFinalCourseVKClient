//
//  NewsLikeTableViewCell.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 03.02.2022.
//

import UIKit

class NewsLikeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likeStackView: UIStackView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentStackView: UIStackView!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var commentView: UIView!
    
    var isHeartActive = false
    var countLike = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeViewConfigure()
        commentViewConfigure()
    }
    
    func configure(_ news: News) {
        likeCountLabel.text = String("\(news.likes)")
        commentCountLabel.text = String("\(news.comments)")
        countLike = news.likes
    }

    private func likeViewConfigure() {
        likeView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        likeView.layer.cornerRadius = 15
        likeButton.tintColor = .lightGray
        likeCountLabel.textColor = .lightGray
    }
    
    private func commentViewConfigure() {
        commentView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        commentView.layer.cornerRadius = 15
        commentButton.tintColor = .lightGray
        commentCountLabel.textColor = .lightGray
    }
    
    @IBAction func pressHeartButton(_ sender: Any) {
        
        let heartImage = UIImage(named: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        
        if isHeartActive {
            UIView.transition(with: likeButton,
                              duration: 0.7,
                              options: .transitionFlipFromTop) {[weak self] in
                self?.likeButton.setImage(heartImage, for: .normal)
                self?.likeButton.tintColor = .lightGray
            }
            
            countLike != 0 ? countLike -= 1 : ()
            likeCountLabel.text = String(countLike)
        }
        else {
            UIView.transition(with: likeButton,
                              duration: 0.7,
                              options: .transitionFlipFromTop) {[weak self] in
                self?.likeButton.setImage(heartImage, for: .normal);
                self?.likeButton.tintColor = .systemRed
                
            }
            countLike += 1
            likeCountLabel.text = String(countLike)
        }
        isHeartActive = !isHeartActive
    }
    
}
