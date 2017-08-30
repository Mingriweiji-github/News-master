//
//  KKConst.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

//Size
let KScreenWidth = UIScreen.main.bounds.size.width
let KScreenHeight = UIScreen.main.bounds.size.height

//Model
let isPhone6 = KScreenHeight == 667 ? true : false
let isPhone6P = KScreenHeight == 736 ? true : false

let isNight = "isNight"
let KMargin: CGFloat = 15.0

let IID: String = "5034850950"
/// iid 和 device_id 好像是绑定到一起的，不对应的话获取不到数据
let device_id: String = "6096495334"

//URL
let BASE_URL = "https://is.snssdk.com/"


let ReturnCode200 = 200
let kAnimationDuration = 0.25

//RGB
func KKColor(r:CGFloat,g:CGFloat,b:CGFloat,aplha:CGFloat)->UIColor{
    
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: aplha)
}
