//
//  CollisionViewController.swift
//  animator
//
//  Created by kyle on 2017/12/8.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class CirclrView: UIView {
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}

class CollisionViewController: UIViewController, UICollisionBehaviorDelegate {

    private var referceBounds = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    private var animator: UIDynamicAnimator!
    private var collisionBehavior: UICollisionBehavior!
    private var gravityBehavior: UIGravityBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Collision"
        animator = UIDynamicAnimator(referenceView: view)
        
        collisionBehavior = UICollisionBehavior(items: [])
        collisionBehavior.collisionDelegate = self;
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

        let identifier = Int.random(in: 1...4)

        let item: CirclrView = .cRandom(point: point)
        item.bounds.size = CGSize(width: identifier * 20, height: identifier * 20)
        item.layer.cornerRadius = item.bounds.height / 2
        view.addSubview(item)

        collisionBehavior.addItem(item)
        gravityBehavior.addItem(item)
    }

    @available(iOS 7.0, *)
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        if (item1.bounds.size.equalTo(item2.bounds.size)) {
            let view1 = item1 as! CirclrView
            view1.bounds.size = CGSize(width: view1.bounds.width * 2, height: view1.bounds.height * 2)
            view1.layer.cornerRadius = view1.bounds.height / 2
            animator.updateItem(usingCurrentState: view1)
            behavior.removeItem(item2)
        }
    }

    private func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

    private func updateItem(_ item: UIDynamicItem) {
        let behaviors = self.animator.behaviors
        // remove all behavior
        delay(0.1) {
            for behavior in self.animator.behaviors {
                self.animator.removeBehavior(behavior)
            }
        }
        self.animator.updateItem(usingCurrentState: item)
        // add all behavior
        delay(0.1) {
            for behavior in behaviors {
                self.animator.addBehavior(behavior)
            }
        }
    }

}
