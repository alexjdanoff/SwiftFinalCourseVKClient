


import UIKit

class FullGalleryVC: UIViewController {
    
    
    @IBOutlet weak var browsingImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    var isHeartActive = false
    var countLike = 0
    var allPhotos:[Photo] = []
    var countCurentPhoto = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browsingImage.load(url: URL(string: allPhotos[countCurentPhoto].photo)!)
    }
    
    @IBAction func pressHeartButton(_ sender: UIButton) {
        
        if isHeartActive {
            UIView.transition(with: heartButton,
                              duration: 0.7,
                              options: .transitionFlipFromTop) {[weak self] in
                self?.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            countLike -= 1
            countLabel.text = String(countLike)
        }
        else {
            UIView.transition(with: heartButton,
                              duration: 0.7,
                              options: .transitionFlipFromTop) {[weak self] in
                self?.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            countLike += 1
            countLabel.text = String(countLike)
        }
        isHeartActive = !isHeartActive
    }
}



