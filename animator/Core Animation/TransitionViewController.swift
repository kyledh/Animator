//
//  TransitionViewController.swift
//  animator
//
//  Created by kyle on 2018/1/5.
//  Copyright © 2018年 kyle. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let item: UIView = .random
        item.backgroundColor = .random
        view.addSubview(item)
    }
}
