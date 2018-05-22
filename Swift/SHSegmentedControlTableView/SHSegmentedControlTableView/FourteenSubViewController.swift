//
//  FourteenSubViewController.swift
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/5/22.
//  Copyright © 2018 angle. All rights reserved.
//

import UIKit

import SHSegmentedControl


class FourteenSubViewController: SHBaseViewController, UITableViewDataSource, UITableViewDelegate {

    override func loadView() {
        super.loadView()
        
        let tableView = SHTableView.init()
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = UIView.init()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view = tableView;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "addChildViewController" + String.init(format: " -- %ld", indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("当前点击的cell--", indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView:SHTableView = self.view as! SHTableView
        if (tableView.isKind(of: SHTableView.classForCoder())) {
            tableView.scrollDidScroll()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
