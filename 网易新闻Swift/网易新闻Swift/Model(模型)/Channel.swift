//
//  Channel.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/21.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit

class Channel: NSObject {
    
    var tname: String?
    var tid: String?
    
    override var description: String {
        let key = ["tname", "tid"]
        return dictionaryWithValuesForKeys(key).description
    }
}