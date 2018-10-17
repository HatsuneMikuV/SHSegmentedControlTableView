//
//  SHHeaderView.swift
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/5/22.
//  Copyright © 2018 angle. All rights reserved.
//

import UIKit

class SHHeaderView: UIView {
    
    open var imageView:UIImageView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = self.getImageView()
        self.imageView.frame = self.bounds
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func getScaleBlock(scaleH:CGFloat) {
        
        let width:CGFloat = self.frame.size.width
        let height:CGFloat = self.frame.size.height
        
        let imgH:CGFloat = scaleH + height
        let imgW:CGFloat = width * imgH / height
        let imgX:CGFloat = (width - imgW) * 0.5
        let imgY:CGFloat = -scaleH
        self.imageView.frame = CGRect.init(x: imgX, y: imgY, width: imgW, height: imgH);
    }
    func getImageView() -> UIImageView {
        if self.imageView != nil {
            return self.imageView
        }
        let imageView:UIImageView = UIImageView.init(image: UIImage.init(named: "123"))
        return imageView
    }

}

@objc protocol SHHeaderOneViewDelegate: NSObjectProtocol {
    
    func changeHeightBlock(_ view:SHHeaderOneView)
}

class SHHeaderOneView: UIView {
    
    open var changeHButton:UIButton!
    
    open weak var delegate:SHHeaderOneViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.changeHButton = UIButton(frame: CGRect(x: 200, y: 150, width: 80, height: 40))
        self.changeHButton.backgroundColor = UIColor.cyan
        self.changeHButton.setTitle("全文增高", for: UIControlState.normal)
        self.changeHButton.setTitle("收起减矮", for: UIControlState.selected)
        self.changeHButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.changeHButton.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)
        self.addSubview(self.changeHButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc open func click(btn:UIButton) {
        btn.isSelected = !btn.isSelected

        /**
         这里需要注意的是，高度必须是0.5的整数倍，保证头部的高度也是0.5的整数倍，防止系统浮点计算取余导致滑动时判断出错，
         比如设置头部高度为200.6，设置后的头部高度实际为200.5999（9循环），然后mainTableview的contentoffset的y值则是200.5
         导致的结果就是mainTableview.contentoffset.y  一直小于  headerView.height
         因此建议值必须是0.5的整数倍，或者可以使用向上取整函数ceilf();
         */
        if btn.isSelected {
            self.height += CGFloat(ceilf(50.5));
        }else {
            self.height -= CGFloat(ceilf(50.5));
        }
        self.delegate?.changeHeightBlock(self)
    }
    
}

