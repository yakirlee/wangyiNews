//
//  UILabel+Extension.swift
//  
//
//  Created by 李 on 16/2/19.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 创建 UILabel
    ///
    /// - parameter text:      text
    /// - parameter fontSize:  fontSize，默认 14
    /// - parameter color:     color，默认 darkGrayColor
    /// - parameter alignment: alignment，默认左对齐
    ///
    /// - returns: UILabel
    
    convenience init(gg_text text: String,
        fontSize: CGFloat = 14,
        color: UIColor = UIColor.darkGrayColor(),
        alignment: NSTextAlignment = .Left) {
            
            self.init()
            
            self.text = text
            self.textColor = color
            self.font = UIFont.systemFontOfSize(fontSize)
            self.textAlignment = alignment
            
            self.numberOfLines = 0
            
            // 自动调整大小
//            sizeToFit()
    }
}
