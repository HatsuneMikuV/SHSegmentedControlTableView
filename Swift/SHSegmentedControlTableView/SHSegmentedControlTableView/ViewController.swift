//
//  ViewController.swift
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/12/7.
//  Copyright © 2017年 angle. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var dataArray: NSArray!
    var tableView: UITableView!
    var controllerArray: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "样式列表"
        
        self.dataArray = ["默认样式", "涌入放大", "右上角小标题", "涌入放大+右上角小标题", "导航栏透明", "无头部", "无bar", "collectionView", "tableView+collectionView", "下拉刷新全部", "下拉刷新当前选中", "独立上拉加载", "头部固定-scrollView容器"]
        
        self.controllerArray = NSArray.init(objects: OneViewController(), TwoViewController(), ThreeViewController(), FourViewController(), FiveViewController(), SixViewController(), SevViewController(), EigViewController(), NineViewController(), TenViewController(),TenViewController(), ZeroViewController(), ElevViewController())
        self.tableView = self.getTableView()
        
        
        self.view.addSubview(self.tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell.textLabel?.text = self.dataArray.object(at: indexPath.row) as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:SHBaseViewController = self.controllerArray.object(at: indexPath.row) as! SHBaseViewController
        if indexPath.row == 9 && vc.isKind(of: TenViewController.classForCoder()) {
            let tenVC:TenViewController = vc as! TenViewController
            tenVC.all = true
        }
        self.navigationController?.pushViewController(self.controllerArray.object(at: indexPath.row) as! UIViewController, animated: true)
    }
    
    func getTableView() -> UITableView {
        
        if self.tableView != nil {
            return self.tableView;
        }
        
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 45;
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView.init()
        return tableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

