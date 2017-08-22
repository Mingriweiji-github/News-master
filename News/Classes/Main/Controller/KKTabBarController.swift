//
//  KKTabBarController.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = UITabBar.appearance()
        tabBar.tintColor = KKColor(r: 245, g: 90, b: 93, aplha: 1.0)
        addControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addControllers() {
        
        addChildVC(childController: KKHomeController(), image: "home_tabbar_32x32_", title: "首页", selectedImage:"home_tabbar_press_32x32_")
        addChildVC(childController: KKVideoController(), image: "video_tabbar_32x32_", title: "视频", selectedImage: "video_tabbar_press_32x32_")
        addChildVC(childController: KKWeiTouTiaoController(), image: "weitoutiao_tabbar_32x32_", title: "微头条", selectedImage: "weitoutiao_tabbar_press_32x32_")
        addChildVC(childController: KKMeViewController(), image: "no_login_tabbar_32x32_", title: "我的", selectedImage: "no_login_tabbar_press_32x32_")
        
    }
    private func addChildVC(childController: UIViewController,image:String,title:String,selectedImage:String) {
        
        childController.tabBarItem.image = UIImage(named:image)
        childController.tabBarItem.title = title
        childController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        let navVC = KKNavigationController(rootViewController: childController)
        addChildViewController(navVC)
    }
    
    
}
