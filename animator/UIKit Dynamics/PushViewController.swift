//
//  PushViewController.swift
//  animator
//
//  Created by kyle on 2017/12/12.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {
    
    private var referceBounds: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    
    private var animator: UIDynamicAnimator!
    private var pushBehavior: UIPushBehavior!
    private var collisionBehavior: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Push"
        animator = UIDynamicAnimator(referenceView: view)
        
        pushBehavior = UIPushBehavior(items: [], mode: .continuous)
        pushBehavior.magnitude = 1.0
        animator.addBehavior(pushBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        // 碰撞边界内边距
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: referceBounds)
        animator.addBehavior(collisionBehavior)
        
        setupViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self.view)
        
        let item = UIView.random(point: point)
        view.addSubview(item)
        
        pushBehavior.addItem(item)
        collisionBehavior.addItem(item)
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(pushXSlide)
        stackView.addArrangedSubview(pushYSlide)
        stackView.addArrangedSubview(magnitudeSlide)
        stackView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.tintColor = .random
        view.bringSubview(toFront: stackView)
        return stackView
    }()
    
    private lazy var pushXSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = -1
        slideView.maximumValue = 1
        slideView.currentValue = pushBehavior.pushDirection.dx
        slideView.title = "向量X"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.pushBehavior.pushDirection.dx = value
        }
        return slideView
    }()
    
    private lazy var pushYSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = -1
        slideView.maximumValue = 1
        slideView.currentValue = pushBehavior.pushDirection.dy
        slideView.title = "向量Y"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.pushBehavior.pushDirection.dy = value
        }
        return slideView
    }()
    
    private lazy var magnitudeSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = -10
        slideView.maximumValue = 10
        slideView.currentValue = pushBehavior.magnitude
        slideView.title = "重力大小"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.pushBehavior.magnitude = value
        }
        return slideView
    }()

}
