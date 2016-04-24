//
//  BaseController.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/19.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit

class BaseController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor.redColor()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
