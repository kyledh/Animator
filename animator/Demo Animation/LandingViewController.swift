//
//  LandingViewController.swift
//  animator
//
//  Created by donghao on 2018/1/9.
//  Copyright © 2018年 kyle. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    
    var gravityBehavior = UIGravityBehavior(items: [])
    var collisionBehavior = UICollisionBehavior(items: []).then {
        $0.translatesReferenceBoundsIntoBoundary = true
    }
    var snapBehavior: UISnapBehavior!

    let squareView: UIView = UIView.random.then {
        $0.isUserInteractionEnabled = true
    }
    
    var timer: Timer!
    
    deinit {
        timer.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        animator = UIDynamicAnimator(referenceView: view)
        collisionBehavior.addItem(squareView)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addItemView), userInfo: nil, repeats: true)
        setupBehaior()
    }
    
    @objc func addItemView() {
        let item = UIView.random(point: CGPoint.init(x: .random(375), y: 0))
        view.addSubview(item)
        gravityBehavior.addItem(item)
        collisionBehavior.addItem(item)
    }
    
    func setupView() {
        squareView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        view.addSubview(squareView)
        snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: view)
        snapBehavior.snapPoint = point
    }

    func setupBehaior() {
        animator.removeAllBehaviors()
        
        animator.addBehavior(snapBehavior)
        animator.addBehavior(gravityBehavior)
        animator.addBehavior(collisionBehavior)
        
    }
}
