//
//  SnapViewController.swift
//  animator
//
//  Created by kyle on 2017/12/12.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit
import SnapKit

class SnapViewController: UIViewController {
    
    private var animator: UIDynamicAnimator!
    private var snapBehavior: UISnapBehavior!
    private var damping: CGFloat = 0.5
    
    private var item: UIView = .random
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Snap"
        
        animator = UIDynamicAnimator(referenceView: view)
        
        item.center = view.center
        item.backgroundColor = .random
        view.addSubview(item)
        
        snapBehavior = UISnapBehavior(item: item, snapTo: view.center)

        setupViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self.view)

        animator.removeAllBehaviors()
        snapBehavior.damping = damping
        animator.addBehavior(snapBehavior)
        
        snapBehavior.snapPoint = point
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(dampingSlide)
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
    
    private lazy var dampingSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = 0
        slideView.maximumValue = 1
        slideView.currentValue = damping
        slideView.title = "震动阻尼"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.damping = value
        }
        return slideView
    }()
}
