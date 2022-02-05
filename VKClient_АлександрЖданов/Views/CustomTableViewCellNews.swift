//
//  CustomTableViewCellNews.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

class CustomTableViewCellNews: UITableViewCell {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tealView: UIView!
    
    let customCellNewsReuseIdentifier = "customCellNewsReuseIdentifier"
    
    var sourceArray: [String] = []
    var isHeartActive = false
    var countLike = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        textView.text = nil
        nameLabel.text = nil
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarComfigure()
        collectionView.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: customCellNewsReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
  
    }


    func configure(news: News) {
        
        if let imageName = news.avatar {
            avatarImageView.image = UIImage(named: imageName)
        }
        sourceArray = news.fotoArray
        textView.text = news.text
        nameLabel.text = news.name
    }
    
    func avatarComfigure() {
        avatarImageView.layer.cornerRadius = tealView.frame.size.height / 2
        tealView.layer.cornerRadius = tealView.frame.size.height / 2
        
    }
    
    @IBAction func pressHeartButton(_ sender: Any) {
        
        if isHeartActive {
            UIView.transition(with: likeButton,
                              duration: 0.7,
                              options: .transitionFlipFromTop) {[weak self] in
                self?.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            countLike -= 1
            likeCountLabel.text = String(countLike)
        }
        else {
            UIView.transition(with: likeButton,
                              duration: 0.7,
                              options: .transitionFlipFromTop) {[weak self] in
                self?.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            countLike += 1
            likeCountLabel.text = String(countLike)
        }
        isHeartActive = !isHeartActive
        
    }
    
}

extension CustomTableViewCellNews: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellNewsReuseIdentifier, for: indexPath) as! GalleryCell
        
        cell.configure(image: UIImage(named: sourceArray[indexPath.item]), index: indexPath.item)
        return cell
    }
}

extension CustomTableViewCellNews: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = collectionView.bounds.width

        return CGSize(width: cellWidth, height: cellWidth)

    }

}
