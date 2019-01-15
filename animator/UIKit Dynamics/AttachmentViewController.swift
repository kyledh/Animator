//
//  AttachmentViewController.swift
//  animator
//
//  Created by kyle on 2017/12/7.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class AttachmentViewController: UIViewController {
    
    private var animator: UIDynamicAnimator!
    private var gravityBehavior: UIGravityBehavior!
    
    private var length: CGFloat = 100
    private var frequency: CGFloat = 1
    private var damping: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        title = "Attachment"
        setupViews()
        animator = UIDynamicAnimator(referenceView: view)
        gravityBehavior = UIGravityBehavior(items: [])
        animator.addBehavior(gravityBehavior)
    }
    
    private func setupViews() {
        view.addSubview(dotView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(lengthSlide)
        stackView.addArrangedSubview(frequencySlide)
        stackView.addArrangedSubview(dampingSlide)
        dotView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(50)
            make.width.height.equalTo(5)
            make.centerX.equalTo(view)
        }
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
        
        let lineLayer = CAShapeLayer()
        lineLayer.lineWidth = 1
        lineLayer.strokeColor = item.backgroundColor?.cgColor
        view.layer.insertSublayer(lineLayer, below: item.layer)

        let attachmentBehavior = UIAttachmentBehavior(item: item, attachedToAnchor: dotView.center)
        attachmentBehavior.length = length
        attachmentBehavior.damping = damping
        attachmentBehavior.frequency = frequency
        attachmentBehavior.action = {
            let path = UIBezierPath()
            path.move(to: self.dotView.center)
            path.addLine(to: item.center)
            lineLayer.path = path.cgPath
        }
        animator.addBehavior(attachmentBehavior)
        
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
    
    private lazy var dotView: UIView = {
        let dotView = UIView()
        dotView.backgroundColor = .random
        dotView.layer.cornerRadius = 2.5
        dotView.layer.masksToBounds = true
        return dotView
    }()

    private lazy var lengthSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = 0
        slideView.maximumValue = 400
        slideView.currentValue = 100
        slideView.title = "锚点距离"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.length = value
        }
        return slideView
    }()

    private lazy var frequencySlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = 0.01
        slideView.maximumValue = 5
        slideView.currentValue = 1
        slideView.title = "振动频率"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.frequency = value
        }
        return slideView
    }()

    private lazy var dampingSlide: SlideView = {
        var slideView = SlideView()
        slideView.minimumValue = 0
        slideView.maximumValue = 10
        slideView.currentValue = 1
        slideView.title = "弹性阻力"
        slideView.valueChange = { [weak self] value in
            guard let strongSelf = self else { return }
            strongSelf.damping = value
        }
        return slideView
    }()
}
