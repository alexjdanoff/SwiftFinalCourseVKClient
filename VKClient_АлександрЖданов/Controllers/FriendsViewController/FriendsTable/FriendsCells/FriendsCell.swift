import UIKit

class FriendsCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var clusure: (() -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarComfigure()
    }
    
    func avatarComfigure() {
        avatarImageView.layer.cornerRadius = containerView.frame.size.height / 2
        containerView.layer.cornerRadius = containerView.frame.size.height / 2
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
        containerView.layer.shadowRadius = 7
        containerView.layer.shadowOpacity = 0.5
    }
    
    @IBAction func pressImegeViewButton(_ sender: UIButton) {
        
        let sourceFrame = avatarImageView.frame
        
        UIImageView.animate(withDuration: 0.2) {[weak self] in
            guard let self = self else {return}
            self.avatarImageView.frame = CGRect.zero
        } completion: { isSuccess in
            if isSuccess { UIView.animate(withDuration: 3,
                                          delay: 0,
                                          usingSpringWithDamping: 0.7,
                                          initialSpringVelocity: 0,
                                          options: [],
                                          animations: {[weak self] in
                guard let self = self else {return}
                self.avatarImageView.frame = sourceFrame
            },
                                          completion: { isSuccessfully in
                if isSuccessfully {
                    self.clusure?()
                    
                }
            })
                
            }
        }
        
    }
    
}
