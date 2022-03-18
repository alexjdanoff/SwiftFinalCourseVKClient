//
//  GalleryVC+NavigationControllerDelegate.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 12.12.2021.
//

import UIKit

extension GalleryVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return TransitionManagerPush()
        } else if operation == .pop {
            return TransitionManagerPop()
        }
        return nil
    }
}
