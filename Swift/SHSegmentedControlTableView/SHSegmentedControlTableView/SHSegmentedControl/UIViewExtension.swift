//
//  UIViewExtension.swift
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/12/12.
//  Copyright © 2017年 angle. All rights reserved.
//

import Foundation
import UIKit

//-----get
func width(_ view: UIView) -> CGFloat {
    return view.frame.size.width
}
func height(_ view: UIView) -> CGFloat {
    return view.frame.size.height
}
func x(_ view: UIView) -> CGFloat {
    return view.frame.origin.x
}
func y(_ view: UIView) -> CGFloat {
    return view.frame.origin.y
}
func size(_ view: UIView) -> CGSize {
    return view.frame.size
}
func origin(_ view: UIView) -> CGPoint {
    return view.frame.origin
}
func centerX(_ view: UIView) -> CGFloat {
    return view.center.x
}
func centerY(_ view: UIView) -> CGFloat {
    return view.center.y
}
//-----set
func setWidth(_ view: UIView, width: CGFloat) {
    var frame:CGRect = view.frame
    frame.size.width = width
    view.frame = frame
}
func setHeight(_ view: UIView, height: CGFloat) {
    var frame:CGRect = view.frame
    frame.size.height = height
    view.frame = frame
}
func setX(_ view: UIView, x: CGFloat) {
    var frame:CGRect = view.frame
    frame.origin.x = x
    view.frame = frame
}
func setY(_ view: UIView, y: CGFloat) {
    var frame:CGRect = view.frame
    frame.origin.y = y
    view.frame = frame
}
func setSize(_ view: UIView, size: CGSize) {
    var frame:CGRect = view.frame
    frame.size = size
    view.frame = frame
}
func setOrigin(_ view: UIView, origin: CGPoint) {
    var frame:CGRect = view.frame
    frame.origin = origin
    view.frame = frame
}
func setCenterX(_ view: UIView, centerX: CGFloat) {
    var point:CGPoint = view.center
    point.x = centerX
    view.center = point
}
func setCenterY(_ view: UIView, centerY: CGFloat) {
    var point:CGPoint = view.center
    point.y = centerY
    view.center = point
}
//---------color
func colorWithHexString(_ color:String) -> UIColor {
    var cString:String! = color.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()

    if cString.lengthOfBytes(using: String.u) {
        <#code#>
    }
    
    
    
}

