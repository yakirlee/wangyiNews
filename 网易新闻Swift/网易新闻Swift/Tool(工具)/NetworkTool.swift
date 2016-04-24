//
//  NetworkTool.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/19.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit
import AFNetworking

///  枚举网络请求
enum RequsetString: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTool: AFHTTPSessionManager {

    /// 网络工具类单例
    static let shareTools: NetworkTool = {
        let tool = NetworkTool(baseURL: NSURL(string:"http://c.m.163.com/nc/article/headline/"))
        
        tool.requestSerializer.timeoutInterval = 15.0
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        (tool.responseSerializer as! AFJSONResponseSerializer).removesKeysWithNullValues = true
        tool.reachabilityManager.startMonitoring()
        return tool
        
    }()
    
    
    ///  下载新闻数据
    ///  - parameter finished: 返回结果
    func loadNewsNews(uid uid: String, finished: ([String: AnyObject]?) -> ()) {
        
       request(.GET, urlString: uid, parameters: nil, finished: finished)
    }
    
    ///  停止连接监听
    deinit {
        reachabilityManager.stopMonitoring()
    }
    var reachable: Bool {
        return reachabilityManager.reachable
    }
    
    
    ///  封装AFN 请求数据
    ///
    ///  - parameter Method:     请求方法
    ///  - parameter urlString:  请求地址
    ///  - parameter parameters: 请求字典
    ///  - parameter finished:   请求回调
    func request(Method: RequsetString, urlString: String, parameters: [String: AnyObject]?, finished:(result:[String: AnyObject]?) -> ()) {
        
        let success = { (task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
            
            if let result = responseObject as? [String: AnyObject] {
                finished(result: result)
            } else {
                print("数据格式错误")
                finished(result: nil)
            }
        }
        let failure = { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            print("网络请求错误 \(error)")
            finished(result: nil)
        }
        
        if Method == .GET {
        GET(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            POST(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    
}
}
