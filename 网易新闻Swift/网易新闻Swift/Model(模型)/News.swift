//
//  Channel.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/20.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit


class News: NSObject {
    
    /// 标题
    var title: String?
    ///  摘要
    var digest: String?
    ///  跟帖数量
    var replyCount: Int = 0
    ///  配图地址
    var imgsrc: String?
    ///  多图数组
    var imgextra: [[String:AnyObject]]?
    ///  大图标记
    var imgType: Bool = false
    
    override var description: String {
        let key = ["title", "digest", "replyCount", "imgsrc", "imgextra", "imgType"]
        return dictionaryWithValuesForKeys(key).description
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
