//
//  NewsViewModel.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/20.
//  Copyright © 2016年 李. All rights reserved.
//

import Foundation
import YYModel

class NewsViewModel {
    
    
 
    ///  新闻数组模型数组
    var newsList = [News]()
    var channelArray = [Channel]()
    
    func loadNewsNews(uid: String?, finished: ([News]) -> ()) {
        let uidStr = uid! + "/0-20.html"
        NetworkTool.shareTools.loadNewsNews(uid: uidStr ?? "") { (result) -> () in
            guard let result = result else {
                return
            }
            let newsName = (result as NSDictionary).keyEnumerator().nextObject() as? String
            
            if let news: AnyObject = result[newsName!]  ,
                let newsArray = news as? [[String : AnyObject]]{
                    
                    var arrayM = [News]()
                    for dict in newsArray {
                        arrayM.append(News.yy_modelWithDictionary(dict)!)
                    }
                    finished(arrayM)
                    self.newsList += arrayM
            }
        }
    }
    
    func channelList() {
        
        let fileUrl = NSBundle.mainBundle().pathForResource("topic_news.json", ofType: nil)
        let data = NSData(contentsOfFile: fileUrl!)
        let dict = try! NSJSONSerialization.JSONObjectWithData(data! , options: []) as? NSDictionary
        let newsName = dict!.keyEnumerator().nextObject() as? String
        
        if let channel: AnyObject = dict![newsName!]  ,
            let channelsArray = channel as? [[String : AnyObject]]{
                
                var arrayM = [Channel]()
                for dict in channelsArray {
                    arrayM.append(Channel.yy_modelWithDictionary(dict)!)
                }
                channelArray += arrayM
        }
    }
}






