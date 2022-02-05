//
//  TransitionManage.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 10.12.2021.
//

import UIKit

class TransitionManagerPush: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {
    
    var presenting = true
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let π = CGFloat.pi
        
        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π / 2)
        let offScreenRotateOut = CGAffineTransform(rotationAngle: π / 2)
        
        toView.transform = self.presenting ? offScreenRotateIn : offScreenRotateOut
        transitionContext.completeTransition(true)
        
        toView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        fromView.layer.anchorPoint = CGPoint(x: 0 ,y: 0)
        
        toView.layer.position = CGPoint(x: 0, y: 0)
        fromView.layer.position = CGPoint(x: 0, y: 0)
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.49, initialSpringVelocity: 0.81, options: [], animations: { () -> Void in
            if self.presenting {
                fromView.transform = offScreenRotateOut
            } else {
                fromView.transform = offScreenRotateIn
            }
            toView.transform = .identity
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
}

