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
        automaticallyAdjustsScrollViewInsets = false
        
        navigationItem.titleView = self.homeNavigationView
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    lazy var pageView: HomePageView = {
        let pageView = HomePageView()
        return pageView
    }()
    fileprivate lazy var homeNavigationView:HomeNavigationView = {
        let homeNavigationView = HomeNavigationView()
        
        homeNavigationView.searchBar.delegate = self as? UITextFieldDelegate
        
        return homeNavigationView
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
extension KKHomeController{

    fileprivate func setupUI(){
    
        view.addSubview(pageView)
    
        pageView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.top.equalTo(view).offset(64.0)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(homeTitleAddButtonClicked(notification:)), name: NSNotification.Name(rawValue:"homeTitleAddButtonClicked"), object: nil)
    }
    
    func homeTitleAddButtonClicked(notification:Notification){
        let titles = notification.object as! [HomeTopicTitle]
        
        print("添加栏目点击了")
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
    
        return .lightContent
    }
    
}


