//
//  SeventeenViewController.swift
//  SHSegmentedControlTableView
//
//  Created by Joe.l on 2018/10/17.
//  Copyright © 2018年 angle. All rights reserved.
//

import UIKit
import SHSegmentedControl

class SeventeenViewController: SHBaseViewController, SHSegTableViewDelegate {
    
    var segTableView:SHSegmentedControlTableView!
    
    var segmentControl:SHSegmentControl!
    
    var headerView:UIView!
    var autoHeight:CGFloat!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = UIRectEdge.all
        self.autoHeight = 64;
        if self.isX() {
            self.autoHeight = 88;
        }
        
        let tab1 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab1.num = 15
        tab1.label = "一"
        
        let tab2 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab2.num = 5
        tab2.label = "二"
        
        let tab3 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab3.num = 30
        tab3.label = "三"
        
        
        self.headerView = self.getHeaderView()
        self.segmentControl = self.getSegmentControl()
        self.segTableView = self.getSegTableView()
        
        self.segTableView.tableViews = [tab1, tab2, tab3]
        
        self.view.addSubview(self.segTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 0.0
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.alpha = 0.0
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.alpha = 1.0
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.alpha = 1.0
    }
    
    func segTableViewDidScrollY(_ offsetY: CGFloat) {
        
        if offsetY > self.autoHeight {
            self.navigationController?.navigationBar.alpha = 1.0
        } else if offsetY < 0 {
            self.navigationController?.navigationBar.alpha = 0.0
        } else {
            self.navigationController?.navigationBar.alpha = offsetY / self.autoHeight
        }
    }
    
    func segTableViewDidScroll(_ tableView: UIScrollView!) {
        
    }
    
    func segTableViewDidScrollSub(_ subTableView: UIScrollView!) {
        
    }
    
    func segTableViewDidScrollProgress(_ progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        if progress == 1 {
            self.segmentControl.setSegmentSelectedIndex(targetIndex)
        }
    }
    
    func getHeaderView() -> UIView {
        if self.headerView != nil {
            return self.headerView
        }
        let header:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
        header.backgroundColor = UIColor.purple
        return header
    }
    func getSegTableView() -> SHSegmentedControlTableView {
        if self.segTableView != nil {
            return self.segTableView
        }
        let segTable:SHSegmentedControlTableView = SHSegmentedControlTableView.init(frame: self.view.bounds)
        segTable.delegateCell = self
        segTable.navStyle = SHSegmentedControlNavStyle.clear
        segTable.topView = self.headerView
        segTable.barView = self.segmentControl
        return segTable
    }
    func getSegmentControl() -> SHSegmentControl {
        if self.segmentControl != nil {
            return self.segmentControl
        }
        let segment:SHSegmentControl = SHSegmentControl.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 45), items: ["分栏一","分栏二","分栏三"])
        segment.titleSelectColor = UIColor.red
        segment.reloadViews()
        weak var weakSelf = self
        segment.curClick = {(index: NSInteger) ->Void in
            // 使用?的好处 就是一旦 self 被释放，就什么也不做
            weakSelf?.segTableView.setSegmentSelect(index)
        }
        return segment
    }

}
