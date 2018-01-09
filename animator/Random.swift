//
//  Random.swift
//  animator
//
//  Created by kyle on 2017/12/12.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class var random: UIColor {
        get {
            return random(1.0)
        }
    }
    
    public class func random(_ alpha: CGFloat) -> UIColor {
        let red = CGFloat.random(256) / 255
        let green = CGFloat.random(256) / 255
        let blue = CGFloat.random(256) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension CGSize {
    
    public static var random: CGSize {
        get {
            return CGSize(width: .random, height: .random)
        }
    }
}

extension CGFloat {
    
    public static var random: CGFloat {
        get {
            return random(100, 20)
        }
    }
    
    public static func random(_ max: Int) -> CGFloat {
        return random(max, 0)
    }
    
    public static func random(_ max: Int, _ min: Int) -> CGFloat {
        return CGFloat(Int(arc4random()) % max + min)
    }
}

extension UIView {
    
    public class var random: UIView {
        get {
            return random(point: .random)
        }
    }
    
    public class func random(point: CGPoint) -> UIView {
        let view = UIView(frame: CGRect(origin: point, size: .random))
        view.backgroundColor = .random
        return view
    }
}

extension CGPoint {
    
    public static var random: CGPoint {
        get {
            let width = UIScreen.main.bounds.size.width
            let height = UIScreen.main.bounds.size.height
            return CGPoint(x: CGFloat.random(Int(width), 50), y: CGFloat.random(Int(height), 100))
        }
    }
}

