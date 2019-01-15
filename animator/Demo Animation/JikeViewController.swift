//
//  JikeViewController.swift
//  animator
//
//  Created by kyle on 2017/12/7.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class JikeViewController: UIViewController {
    
    private var originPoint: CGPoint = .zero
    private var animator: UIDynamicAnimator!
    private var attachmentBehavior: UIAttachmentBehavior? = nil
    private var snapBehavior: UISnapBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Jike Avatar"
        
        animator = UIDynamicAnimator(referenceView: view)
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.top.equalTo(view).offset(150)
            make.centerX.equalTo(view)
        }

        view.layoutIfNeeded()
        originPoint = imageView.center
    }

    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
            let point = sender.location(in: view)
            if sender.state == .began {
                animator.removeAllBehaviors()
                let offset = UIOffset(horizontal: point.x - originPoint.x, vertical: point.y - originPoint.y)
                attachmentBehavior = UIAttachmentBehavior(item: imageView, offsetFromCenter: offset, attachedToAnchor: point)
                animator.addBehavior(attachmentBehavior!)
            } else if sender.state == .changed {
                attachmentBehavior?.anchorPoint = point
            } else if sender.state == .ended || sender.state == .cancelled || sender.state == .failed {
                let currentPoint = imageView.center
                imageView.transform = .identity
                animator.removeAllBehaviors()
                imageView.center = currentPoint
                let snapBehavior = UISnapBehavior(item: imageView, snapTo: originPoint)
                snapBehavior.damping = 0.5
                animator.addBehavior(snapBehavior)
            }
    }
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "avatar")
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        imageView.addGestureRecognizer(panGestureRecognizer)
        return imageView
    }()
    
}
