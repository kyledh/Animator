//
//  BallView.swift
//  animator
//
//  Created by kyle on 2018/1/8.
//  Copyright © 2018年 kyle. All rights reserved.
//

import UIKit

class BallView: UIView {
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}

extension BallView {
    
    class var randomBall: BallView {
        get {
            return randomBall(point: .random)
        }
    }
    
    class func randomBall(point: CGPoint) -> BallView {
        let width = CGFloat.random
        let view = BallView(frame: CGRect(origin: point, size: CGSize(width: width, height: width)))
        view.backgroundColor = .random
        view.layer.cornerRadius = width / 2
        return view
    }
}
