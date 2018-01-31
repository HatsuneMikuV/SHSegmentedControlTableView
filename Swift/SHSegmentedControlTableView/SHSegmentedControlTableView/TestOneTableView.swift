//
//  TestOneTableView.swift
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/1/30.
//  Copyright © 2018年 angle. All rights reserved.
//

import UIKit

import SHSegmentedControl

class TestOneTableView: SHTableView, UITableViewDataSource, UITableViewDelegate {
    
    open var label:String!
    
    open var num:NSInteger = 0
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)

        self.dataSource = self
        self.delegate = self
        self.rowHeight = 45
        self.tableFooterView = UIView.init()
        self.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.allowsSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setNum(num: NSInteger) {
        self.num = num;
        self.reloadData()
    }
    
    open func setLabel(label: String) {
        self.label = label;
        self.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.label + String.init(format: "%ld -- %ld", indexPath.section, indexPath.row)
        return cell
    }
}
