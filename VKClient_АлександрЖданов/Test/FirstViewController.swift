

import UIKit


class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
    }
    
    @IBAction func unwindToViewController(sender: UIStoryboardSegue) {
        
    }
}

extension ViewController: UINavigationControllerDelegate {
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return TransitionManager()
    }
}


    
    
    
    

