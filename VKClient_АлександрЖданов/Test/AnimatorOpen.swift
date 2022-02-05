//
//  AnimatorOpen.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 12.12.2021.
//

import UIKit

class AnimatorOpen: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 3
    }


    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else{return}
        
        let containerFrame = transitionContext.containerView.frame
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = CGRect(x: containerFrame.width / 2, y: containerFrame.height / 2, width: 0, height: 0)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext) / 2) {
            source.view.frame = CGRect(x: containerFrame.width / 2, y: containerFrame.height / 2, width: 0, height: 0)
        } completion: { _ in
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext) / 2) {
                destination.view.frame = CGRect(x: 0, y: 0, width: containerFrame.width, height: containerFrame.height)
            } completion: { isSuccess in
                transitionContext.completeTransition(isSuccess)
            }
        }
    }

}
