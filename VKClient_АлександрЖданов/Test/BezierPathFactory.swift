//
//  BezierPathFactory.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 08.12.2021.
//

import UIKit

@IBDesignable class BezierPathFactory: UIView {






































    @IBInspectable var currentColor: UIColor = UIColor.systemGreen


    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let cgContext = UIGraphicsGetCurrentContext() else {return}

        cgContext.setStrokeColor(currentColor.cgColor)
        cgContext.interpolationQuality = .high

        let path = UIBezierPath()

        path.move(to: CGPoint(x: 140, y: 520))
        path.addLine(to: CGPoint(x: 145, y: 540))
        path.addLine(to: CGPoint(x: 160, y: 515))


        cgContext.addPath(path.cgPath)
        cgContext.strokePath()


        let circleLayer = CAShapeLayer()
        circleLayer.backgroundColor = UIColor.systemRed.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        circleLayer.cornerRadius = 10
        circleLayer.position = CGPoint(x: 40, y: 20)

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.speed = 0.1
        animation.repeatCount = Float.infinity
        animation.calculationMode = CAAnimationCalculationMode.cubicPaced

        circleLayer.add(animation, forKey: nil)
        self.layer.addSublayer(circleLayer)



        
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.fromValue = 0
//        animation.toValue = 1
//
//        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
//        strokeStartAnimation.fromValue = 0
//        strokeStartAnimation.toValue = 1
//
//        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        strokeEndAnimation.fromValue = 0
//        strokeEndAnimation.toValue = 1.2
//
//        let animationGroup = CAAnimationGroup()
//        animationGroup.duration = 2
//        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
//
//
//        animation.speed = 0.1
//        animation.repeatCount = Float.infinity
//
//
//        circleLayer.add(animation, forKey: nil)
//        self.layer.addSublayer(circleLayer)
//
        
        
//
//
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//
//
//    static func checkMark(gridSpacing G: CGFloat) -> UIBezierPath {
//
//           let blurp = UIBezierPath()
//
//            let CM_hyp = ((sqrt(18))/5) * G
//
//            let CM_opp_or_adj = sqrt( ((CM_hyp)*(CM_hyp)) / 2 )
//
//            let startPoint = CGPoint(x: 4*G, y: G)
//
//            blurp.move(to: startPoint)
//            blurp.addLine(to: CGPoint(x: (4*G)+CM_opp_or_adj, y: G + CM_opp_or_adj))
//            blurp.addLine(to: CGPoint(x: (4*G)-(3*CM_opp_or_adj), y: 4*G) )
//            //3
//            blurp.addLine(to: CGPoint( x: G, y:(4*G) - 2*CM_opp_or_adj ))
//
//            blurp.addLine(to: CGPoint( x: G + CM_opp_or_adj, y: (4*G) - 3*CM_opp_or_adj ) )
//            blurp.addLine(to: CGPoint( x: (4*G)-(3*CM_opp_or_adj), y: (4*G) - 2*CM_opp_or_adj ) )
//            blurp.addLine(to: startPoint)
//
//            blurp.close()
//            // !!
//            return blurp
//
//
//        }
//
//    static func checkMarkBox(gridSpacing G: CGFloat) -> UIBezierPath {
//
//            let boxPath = UIBezierPath()
//
//            boxPath.move(to: CGPoint(x:G, y: G))
//            boxPath.addLine(to: CGPoint(x:4*G, y: G))
//            boxPath.addLine(to: CGPoint(x:4*G, y: 4*G))
//            boxPath.addLine(to: CGPoint(x:G, y: 4*G))
//            boxPath.addLine(to: CGPoint(x:G, y: G))
//
//            boxPath.close()
//
//            return boxPath
//
//        }
    
}
