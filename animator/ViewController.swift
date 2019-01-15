//
//  ViewController.swift
//  animator
//
//  Created by kyle on 2017/12/7.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit
import SnapKit

private typealias RowData = (title: String, classType: UIViewController.Type)

class ViewController: UIViewController {
    
    private var uikitDynamicsData: [RowData] = [
        ("UIGravityBehavior", GravityViewController.self),
        ("UICollisionBehavior", CollisionViewController.self),
        ("UIAttachmentBehavior", AttachmentViewController.self),
        ("UIPushBehavior", PushViewController.self),
        ("UISnapBehavior", SnapViewController.self),
    ]
    
    private var coreAnimationData: [RowData] = [
        ("Transition", TransitionViewController.self)
    ]
    
    private var demoAnimationData: [RowData] = [
        ("JikeAvatar", JikeViewController.self),
        ("Shoot", ShootViewController.self),
        ("Landing", LandingViewController.self)
    ]
    
    private var tableData: [(title: String, rowData: [RowData])]!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Animator"
        tableData = [("UIKit Dynamics", uikitDynamicsData),
                     ("Core Animation", coreAnimationData),
                     ("Demo Animation", demoAnimationData)]
        tableView.reloadData()
    }
   
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ (make) in
            make.edges.equalTo(view)
        })
        return tableView
    }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].rowData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableData[indexPath.section].rowData[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        }
        cell?.textLabel?.text = row.title
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: false)
        let row = tableData[indexPath.section].rowData[indexPath.row]
        let vc = row.classType.init()
//        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
//        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(vc, animated: true)
    }
}
