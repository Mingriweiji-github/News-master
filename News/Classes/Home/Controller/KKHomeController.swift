//
//  KKHomeController.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import SwiftTheme

class KKHomeController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.theme_barTintColor = "colors.homeNavBarTintColor"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.globalBackgroundColor()
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = HomeNavigationView()
        
        automaticallyAdjustsScrollViewInsets = false
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    fileprivate func homeNavigationView:
}
