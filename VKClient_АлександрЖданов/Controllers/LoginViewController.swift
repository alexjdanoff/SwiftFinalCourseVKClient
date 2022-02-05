
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    private let toGreenSegue = "fromLoginToGreen"
    private let animateTitleImage = CASpringAnimation(keyPath: "position.y")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginLabel.transform = CGAffineTransform(translationX: -(self.view.frame.width), y: 0)
        passwordLabel.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
        titleLabel.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.width))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateLabel()
        animateImage()
        animateButton()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(onPressed(_:)), name: Notification.Name("pressLoginButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        recognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(recognizer)
    }
    
    func animateLabel() {
        UIView.animate(withDuration: 2) {
            self.loginLabel.transform = .identity
            self.passwordLabel.transform = .identity
            self.titleLabel.transform = .identity
        }
    }
    
    func animateImage() {
        animateTitleImage.fromValue = 50
        animateTitleImage.toValue = self
        animateTitleImage.duration = 2
        animateTitleImage.stiffness = 400
        animateTitleImage.mass = 25
        animateTitleImage.fillMode = .forwards
        animateTitleImage.isRemovedOnCompletion = false
        titleImage.layer.add(animateTitleImage, forKey: nil)
    }
    
    func animateButton() {
        UIButton.transition(with: loginButton,
                            duration: 2,
                            options: .transitionFlipFromTop,
                            animations: nil)
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil);            alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        loginTextField.layer.masksToBounds = true
        loginTextField.layer.borderColor = UIColor.red.cgColor
        loginTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.borderWidth = 1.0
        
        let theButton = loginButton!
        let bounds = theButton.bounds
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut,
                       animations: {
            theButton.bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
        }) { (success: Bool) in
            if success {
                UIView.animate(withDuration: 0.5, animations: {
                    theButton.bounds = bounds
                })
            }
        }
    }
    
    @objc func onTap(_ recognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    @objc func keyboardDidShow(_ notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        guard let keyboardHeight = keyboardSize?.height else {return}
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 100, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
//    @objc func onPressed(_ notification: Notification) {
//        if notification.object != nil {
//            func checkUserData() -> Bool {
//                guard let login = loginTextField.text,
//                      let password = passwordTextField.text else { return false }
//
//                if login == "Alex" && password == "1234" {
//                    return true
//                } else {
//                    return false
//                }
//            }
//
//            if checkUserData() == true {
//                UIView.transition(with: loginButton,
//                                  duration: 0.175,
//                                  options: .transitionFlipFromTop) {[weak self] in
//                    self?.loginButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
//                }
//                performSegue(withIdentifier: toGreenSegue, sender: nil)
//            } else {
//                showLoginError()
//            }
//        }
//    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func pressLoginButton(_ sender: Any) {
        _ = shouldPerformSegue
        
        NotificationCenter.default.post(name: Notification.Name("pressLoginButton"), object: shouldPerformSegue)
        
    }
}

