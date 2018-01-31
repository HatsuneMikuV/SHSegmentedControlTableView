//
//  ZeroViewController.swift
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/1/30.
//  Copyright © 2018年 angle. All rights reserved.
//

import UIKit

import SHSegmentedControl


class ZeroViewController: SHBaseViewController, SHSegTableViewDelegate {
    
    var segTableView:SHSegmentedControlTableView!
    
    var segmentControl:SHSegmentControl!
    
    var headerView:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let tab1 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab1.num = 15
        tab1.label = "一"
        let mj_footer1 = MJRefreshAutoNormalFooter.init()
        weak var weakMj_footer1 = mj_footer1
        mj_footer1.refreshingBlock = {
            NSLog("%ld", tab1.num)
            tab1.setNum(num: tab1.num + 2)
            weakMj_footer1?.endRefreshing();
        }
        tab1.mj_footer = mj_footer1;
        
        let tab2 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab2.num = 5
        tab2.label = "二"
        
        let tab3 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab3.num = 30
        tab3.label = "三"
        let mj_footer3 = MJRefreshAutoNormalFooter.init()
        weak var weakMj_footer3 = mj_footer3
        mj_footer3.refreshingBlock = {
            if tab3.num >= 2 {
                tab3.setNum(num: tab3.num - 2)
            }
            if tab3.num == 0 {
                weakMj_footer3?.endRefreshingWithNoMoreData();
            }else {
                weakMj_footer3?.endRefreshing();
            }
        }
        tab3.mj_footer = mj_footer3;

        
        
        self.headerView = self.getHeaderView()
        self.segmentControl = self.getSegmentControl()
        self.segTableView = self.getSegTableView()
        
        self.segTableView.tableViews = [tab1, tab2, tab3]
        
        self.view.addSubview(self.segTableView)
        
    }
    
    func segTableViewDidScrollY(_ offsetY: CGFloat) {
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
