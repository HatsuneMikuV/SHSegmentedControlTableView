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
    
    open func getScaleBlock(scaleH:CGFloat) -> () {
        
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
