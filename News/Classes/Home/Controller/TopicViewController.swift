//
//  TopicViewController.swift
//  News
//
//  Created by M_Li on 2017/8/29.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import BMPlayer
import RxSwift
import RxCocoa
import MJRefresh
import SVProgressHUD

class TopicViewController: UIViewController {

    var topicTitle : HomeTopicTitle?
    var player = BMPlayer()
    var disposeBag = DisposeBag()
    var lastSelectedIndex = 0
    var newsTopic = [WeiTouTiao]()
    
    
    /***************API****************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        if topicTitle?.category == "subscription" {//头条号
            tableView.tableHeaderView = toutiaoHeader
        }
        
        setRefresh()
        
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        
        view.addSubview(tableView)
    }
    
   fileprivate lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 232
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return tableView
    }()
    
    lazy var toutiaoHeader:ToutiaoHaoHeaderView  = {
        let toutiaoHeader = ToutiaoHaoHeaderView()
        toutiaoHeader.delegate = self as ToutiaohaoHeaderViewDelegate
        toutiaoHeader.height = 56
        return toutiaoHeader
    }()
    
    
}
extension TopicViewController : ToutiaohaoHeaderViewDelegate{

    func toutiaoHeaderButtonClicked(){
    
//        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    print("toutiaoHeaderButtonClicked")
        
    }

}
extension TopicViewController{

    @objc fileprivate func setRefresh(){
    
        let header = RefreshHeader { 
            [weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: (self?.topicTitle?.category)!, completeHandler: { (nowTime, newsTopics) in
                self?.tableView.mj_header.endRefreshing()
                self?.newsTopic = newsTopics
                self?.tableView.reloadData()
            })
        }
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { 
            [weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: self!.topicTitle!.category!, completeHandler: { (nowtime, newsTopics) in
                
                self?.tableView.mj_footer.endRefreshing()
                if newsTopics.count == 0 {
                
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    SVProgressHUD.showInfo(withStatus: "没有更多新闻了")
                    return
                }
                self?.newsTopic += newsTopics
                self?.tableView.reloadData()
                
            })
        })
    
    }
    
    @objc fileprivate func tabbarSelected(){
    
        if lastSelectedIndex != tabBarController?.selectedIndex {
            tableView.mj_header.beginRefreshing()
        }
        lastSelectedIndex = tabBarController!.selectedIndex
    }


}
extension TopicViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topicTitle?.category == "subscription" {
            return 10
        }else{
            return  newsTopic.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        return  cell
    }
    private func showVideoCell(indexpath:IndexPath) -> VideoTopicCell{
        
        let cell = Bundle.main.loadNibNamed(String(describing:VideoTopicCell.self), owner: nil, options: nil)?.last as! VideoTopicCell
        cell.videoTopic = newsTopic[indexpath.row]
        
        //header
//        cell.headerBtn.rx.controlEvent(.touchUpInside)
//            .subscribe(onNext: { [weak self] in
//                
//                let userVC 
//                
//            }, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//        
        //播放器点击
        cell.playButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                //rx.controlEvent方法添加播放器
                cell.playButton.addSubview(self!.player)
                
//                self?.player.snp.makeConstraints({ (make) in
//                    make.edges.equalTo(cell.)
//                })
                NetworkTool.parseVideoRealURL(video_id: cell.videoTopic!.video_id!, completeHandler: { (realVideo) in
                    
                    self!.player.backBlock = {(isFullScreen) in
                        
                        if isFullScreen == true{
                            return
                        }
                        let asset = BMPlayerResource(url: URL(string:realVideo.video_1!.main_url!)!, name: cell.titleLabel.text!)
                        
                        self!.player.setVideo(resource: asset)
                    }
                })
                
            })
        .addDisposableTo(disposeBag)
        
        return cell
    }

}
extension TopicViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if topicTitle!.category == "video" {
            return KScreenHeight * 0.3
        }else if topicTitle!.category == "subscription" {
            return 68
        }else if topicTitle!.category == "essay_joke" {
            return 60
        }else{
        
            let weitoutiao = newsTopic[indexPath.row]
            if weitoutiao.cell_type! == 32 {
                return weitoutiao.contentHeight!
            }else if weitoutiao.cell_type! == 50{
                return 300
            }
            
            return weitoutiao.homeCellHeight!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
