//
//  LandingViewController.swift
//  animator
//
//  Created by kyle on 2018/1/9.
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Landing"
        
        setupView()
        animator = UIDynamicAnimator(referenceView: view)
        collisionBehavior.addItem(squareView)
        setupBehaior()
    }

    @objc func addItemView() {
        let item = UIView.random(point: CGPoint(x: .random(in: 0...375), y: 0))
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
        if recognizer.state == .began {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addItemView), userInfo: nil, repeats: true)
        } else if recognizer.state == .changed {
            snapBehavior.snapPoint = point
        } else {
            timer.invalidate()
        }
    }

    func setupBehaior() {
        animator.removeAllBehaviors()
        
        animator.addBehavior(snapBehavior)
        animator.addBehavior(gravityBehavior)
        animator.addBehavior(collisionBehavior)
        
    }
}
