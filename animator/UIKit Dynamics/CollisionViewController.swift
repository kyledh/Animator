//
//  CollisionViewController.swift
//  animator
//
//  Created by kyle on 2017/12/8.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class CollisionViewController: UIViewController {
    
    private var referceBounds: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)

    private var animator: UIDynamicAnimator!
    private var collisionBehavior: UICollisionBehavior!
    private var gravityBehavior: UIGravityBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Collision"
        animator = UIDynamicAnimator(referenceView: view)
        
        collisionBehavior = UICollisionBehavior(items: [])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        // 碰撞边界内边距
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: referceBounds)
        animator.addBehavior(collisionBehavior)
        
        gravityBehavior = UIGravityBehavior(items: [])
        animator.addBehavior(gravityBehavior)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self.view)
        
        let item: UIView = .random(point: point)
        view.addSubview(item)
        
        collisionBehavior.addItem(item)
        gravityBehavior.addItem(item)
    }

}
