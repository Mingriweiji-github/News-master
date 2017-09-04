//
//  NetworkTool.swift
//  News
//
//  Created by M_Li on 2017/8/30.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkTool{
    
    //Mark:首页
   class func loadHomeData(fromVC:String,completeHandler:@escaping (_ topTitles:[HomeTopicTitle],_ topicVCs:[TopicViewController]) -> ()){
        
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id":device_id,"aid":13,"iid":IID] as [String :AnyObject]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            
            guard response.result.isSuccess else{return}
            
            if let value = response.result.value{
            
                let json = JSON(value)
                let dataDic = json["data"].dictionary
                if let data = dataDic!["data"]?.arrayObject{
                
                    var titles = [HomeTopicTitle]()
                    var homeTopicVCs = [TopicViewController]()
                    //推荐标题
                    let recommandDic = ["category":"","name":"推荐"]
                    let recommand = HomeTopicTitle(dict: (recommandDic as [String: AnyObject]))
                    titles.append(recommand)
                    //推荐的控制器
                    let firstVC = TopicViewController()
                    firstVC.topicTitle = recommand
                    homeTopicVCs.append(firstVC)
                    for dict in data{
                    
                        let topicTitle = HomeTopicTitle(dict: (dict as? [String:AnyObject])!)
                        titles.append(topicTitle)
                        let homeTopicVC = TopicViewController()
                        homeTopicVC.topicTitle = topicTitle
                        homeTopicVCs.append(homeTopicVC)
                    }
                    
                    completeHandler(titles,homeTopicVCs)
                }
            }
            
        }        
    }

    //MARK:解析视频
    class func parseVideoRealURL(video_id:String,completeHandler:@escaping(_ realVideo:RealVideo)->()){
    
        let random = arc4random()
        let url:NSString = "/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(random)" as NSString
        let data:NSData = url.data(using: String.Encoding.utf8.rawValue)! as NSData
        var crc32 = data.getCRC32()
        if crc32 < 0 {
            crc32 += 0x100000000
        }
        
        let realURL = "http://i.snssdk.com/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(random)&s=\(crc32)"
        Alamofire.request(realURL)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else{
                
                    return
                }
                
                if let value = response.result.value{
                
                    let json = JSON(value)
                    let dict = json["data"].dictionaryObject
                    let video = RealVideo(dict: dict! as [String:AnyObject])
                    completeHandler(video)
                }
                
        }
    
    
    }
    //获取首页不同分类的内容和视频的内容使用同一接口
   class func loadHomeCategoryNewsFeed(category:String,completeHandler:@escaping(_ nowTime:TimeInterval,_ newsTopics:[WeiTouTiao])->()){
    
    let url = BASE_URL + "api/news/feed/v58/?"
    let params = ["device_id": device_id,
                  "category": category,
                  "iid": IID,
                  "device_platform": "iphone",
                  "version_code": versionCode]
    let nowtime = NSDate().timeIntervalSince1970
    Alamofire.request(url,parameters:params)
        .responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value{
            
                let json = JSON(value)
                guard let dataJSON = json["data"].array else{return}
                var topics = [WeiTouTiao]()
                for data in dataJSON{
                   if let content = data["content"].string {
                    
                        let contentData:NSData = content.data(using:String.Encoding.utf8)! as NSData
                        do{
                        
                            let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            let topic  = WeiTouTiao(dict: dict as! [String:AnyObject])
                            topics.append(topic)
                            print("------------")
                        }catch{
                        
                        }
                    
                    }
                }
                
                completeHandler(nowtime,topics)
                
            }
            
    }
}
    
    
    
    
    
    
    
    
    
}
