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


//URL
let BASE_URL = "http://api.dantangapp.com/"
let KKTopData = "v2/channels/preset"
let KKProductData = "v2/items"

let ReturnCode200 = 200
let kAnimationDuration = 0.25

//RGB
func KKColor(r:CGFloat,g:CGFloat,b:CGFloat,aplha:CGFloat)->UIColor{
    
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: aplha)
}
