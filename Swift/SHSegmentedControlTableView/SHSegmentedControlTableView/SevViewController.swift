//
//  SevViewController.swift
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/1/30.
//  Copyright © 2018年 angle. All rights reserved.
//

import UIKit

import SHSegmentedControl


class SevViewController: SHBaseViewController, SHSegTableViewDelegate {
    
    var segTableView:SHSegmentedControlTableView!
    
    var headerView:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        return segTable
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
