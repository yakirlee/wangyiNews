//
//  UIImage+Extension.swift
//  
//
//  Created by 李 on 16/2/19.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit

extension UIImage {
   
    class func gg_singleDotImage(color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, UIScreen.mainScreen().scale)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
    
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    /// 异步绘制图像
    func gg_asyncDrawImage(size: CGSize,
        isCorner: Bool = false,
        backColor: UIColor? = UIColor.whiteColor(),
        finished: (image: UIImage)->()) {

            dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
                
                UIGraphicsBeginImageContextWithOptions(size, backColor != nil, UIScreen.mainScreen().scale)
                let rect = CGRect(origin: CGPointZero, size: size)
                backColor?.setFill()
                UIRectFill(rect)
                
                if isCorner {
                    let path = UIBezierPath(ovalInRect: rect)
                    // 添加裁切路径 - 后续的绘制，都会被此路径裁切掉
                    path.addClip()
                }
                // 绘制图像
                self.drawInRect(rect)
                let result = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                // 主线程更新 UI
                dispatch_async(dispatch_get_main_queue()) {
                    finished(image: result)
                }
            }
    }
}
