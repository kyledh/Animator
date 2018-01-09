//
//  ShootViewController.swift
//  animator
//
//  Created by kyle on 2018/1/8.
//  Copyright © 2018年 kyle. All rights reserved.
//

import UIKit

class ShootViewController: UIViewController {

    var animator: UIDynamicAnimator!
    
    var gravityBehavior = UIGravityBehavior(items: [])
    var collisionBehavior = UICollisionBehavior(items: []).then {
        $0.translatesReferenceBoundsIntoBoundary = true
    }
    var pushBehavior = UIPushBehavior(items: [], mode: .instantaneous)

    let ball = BallView().then {
        $0.backgroundColor = .random
        $0.layer.cornerRadius = 15
        $0.isUserInteractionEnabled = true
    }
    
    let lineLayer = CAShapeLayer().then {
        $0.lineWidth = 2
        $0.lineDashPattern = [5]
        $0.strokeColor = UIColor.random(0.5).cgColor
        $0.fillColor = UIColor.clear.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Shoot"
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGR)
        
        animator = UIDynamicAnimator(referenceView: view)
        animator.addBehavior(collisionBehavior)

        view.addSubview(ball)
        ball.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(50)
            make.bottom.equalTo(view).offset(-100)
            make.width.height.equalTo(30)
        }
        
        view.layer.insertSublayer(lineLayer, below: ball.layer)
        view.layoutIfNeeded()

        pushBehavior.addItem(ball)
        gravityBehavior.addItem(ball)
        collisionBehavior.addItem(ball)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        animator.removeBehavior(pushBehavior)
        animator.removeBehavior(gravityBehavior)
        pushBehavior = UIPushBehavior(items: [ball], mode: .instantaneous)
        
        let path = UIBezierPath()
        path.move(to: ball.center)
        
        let point = recognizer.location(in: view)
        pushBehavior.angle = atan2(point.y - ball.center.y, point.x - ball.center.x)
        pushBehavior.magnitude = 0.5
        pushBehavior.action = {
            path.addLine(to: self.ball.center)
            self.lineLayer.path = path.cgPath
        }
        
        animator.addBehavior(pushBehavior)
        animator.addBehavior(gravityBehavior)
    }
}
