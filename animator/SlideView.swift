//
//  SlideView.swift
//  animator
//
//  Created by kyle on 2017/12/8.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

class SlideView: UIView {
    
    public var valueChange: ((_ value: CGFloat) -> Void)?
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var minimumValue: CGFloat? {
        didSet {
            let value = String(format: "%.2f", minimumValue ?? 0)
//            minimumLabel.text = value
            slide.minimumValue = Float(value)!
        }
    }
    public var maximumValue: CGFloat? {
        didSet {
            let value = String(format: "%.2f", maximumValue ?? 0)
//            maximumLabel.text = value
            slide.maximumValue = Float(value)!
        }
    }
    public var currentValue: CGFloat? {
        didSet {
            let value = String(format: "%.2f", currentValue ?? 0)
            currentLabel.text = value
            slide.value = Float(value)!
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    private func setupViews() {
        snp.makeConstraints { (make) in
            make.height.equalTo(30)
        }
        addSubview(slide)
        addSubview(titleLabel)
//        addSubview(minimumLabel)
        addSubview(currentLabel)
//        addSubview(maximumLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.width.equalTo(70)
            make.centerY.equalTo(self)
        }
//        minimumLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(titleLabel.snp.right).offset(5)
//            make.width.equalTo(40)
//            make.centerY.equalTo(self)
//        }
        slide.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.right.equalTo(currentLabel.snp.left).offset(-5)
            make.centerY.equalTo(self)
        }
//        maximumLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(currentLabel.snp.left).offset(-5)
//            make.width.equalTo(40)
//            make.centerY.equalTo(self)
//        }
        currentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(60)
            make.centerY.equalTo(self)
        }
    }

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
//    private lazy var minimumLabel: UILabel = {
//        var label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textAlignment = .center
//        return label
//    }()
    
    private lazy var currentLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
//    private lazy var maximumLabel: UILabel = {
//        var label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textAlignment = .center
//        return label
//    }()

    private lazy var slide: UISlider = {
        var slide = UISlider()
        slide.isContinuous = true
        slide.addTarget(self, action: #selector(slideValueChange(_:)), for: .valueChanged)
        return slide
    }()
    
    @objc private func slideValueChange(_ sender: UISlider) {
        currentLabel.text = String(format: "%.2f", sender.value)
        valueChange?(CGFloat(sender.value))
    }

}

