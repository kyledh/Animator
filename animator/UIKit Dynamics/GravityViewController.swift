//
//  GravityViewController.swift
//  animator
//
//  Created by kyle on 2017/12/8.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {
    
    private var animator: UIDynamicAnimator!
    private var gravityBehavior: UIGravityBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Gravity"
        animator = UIDynamicAnimator(referenceView: view)
        
        gravityBehavior = UIGravityBehavior(items: [])
        // 重力向量和角度同时存在时，角度不生效
        // gravityBehavior.angle = 0
        animator.addBehavior(gravityBehavior)
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(gravityXSlide)
        stackView.addArrangedSubview(gravityYSlide)
        stackView.addArrangedSubview(magnitudeSlide)
        stackView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self.view)
        
        let item: UIView = .random(point: point)
        view.addSubview(item)
        
        gravityBehavior.addItem(item)
    }
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.tintColor = .random
        view.bringSubviewToFront(stackView)
        return stackView
    }()

//    private lazy var angleSlide: SlideView = {
//        var slideView = SlideView()
//        slideView.minimumValue = 0
//        slideView.maximumValue = .pi
//        slideView.currentValue = gravityBehavior.angle
//        slideView.title = "角度"
//        slideView.valueChange = { [weak self] value in
//            guard let strongSelf = self else { return }
//            strongSelf.gravityBehavior.angle = value
//        }
//        return slideView
//    }()
    
    private lazy var gravityXSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = 0
        slideView.maximumValue = 10
        slideView.currentValue = gravityBehavior.gravityDirection.dx
        slideView.title = "向量X"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.gravityBehavior.gravityDirection.dx = value
        }
        return slideView
    }()
    
    private lazy var gravityYSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = 0
        slideView.maximumValue = 10
        slideView.currentValue = gravityBehavior.gravityDirection.dy
        slideView.title = "向量Y"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.gravityBehavior.gravityDirection.dy = value
        }
        return slideView
    }()

    private lazy var magnitudeSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = 0
        slideView.maximumValue = 10
        slideView.currentValue = gravityBehavior.magnitude
        slideView.title = "重力大小"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.gravityBehavior.magnitude = value
        }
        return slideView
    }()

}
