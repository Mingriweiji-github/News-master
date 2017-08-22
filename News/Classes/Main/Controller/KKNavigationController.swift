//
//  KKNavigationController.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class KKNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nav = UINavigationBar.appearance()
        nav.barTintColor = UIColor.white
        nav.tintColor = KKColor(r: 0, g: 0, b: 0, aplha: 0.7)
        nav.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18)]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:""), style: .plain, target: self, action: #selector(navigationBackAction))
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    func navigationBackAction() {
    
        popViewController(animated: true)
    }

}
//全局返回手势
extension KKNavigationController:UIGestureRecognizerDelegate{

   fileprivate func initGlobleGestureRecognizer() {
        
        let target = interactivePopGestureRecognizer?.delegate
    //handleNavigationTransition:该方法是隐藏方法，在OC里调用一个没有声明的方法仅仅只是报警，由于Swift对安全性的要求，我们要用老的方法Selector来调用
        let panGeture = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        panGeture.delegate = self
        self.view.addGestureRecognizer(panGeture)
         //禁用系统手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return self.childViewControllers.count != 1
        
    }

}
