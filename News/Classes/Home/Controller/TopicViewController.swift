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

class TopicViewController: UIViewController {

    var topicTitle : HomeTopicTitle?
    var player = BMPlayer()
    var disposeBag = DisposeBag()
    var lastSelectedIndex = 0
    var newsTopic = [WeiTouTiao]()
    
    
    /***************API****************/
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        //播放器点击
        cell.playButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                //rx.controlEvent方法添加播放器
                cell.playButton.addSubview(self!.player)
                
//                self?.player.snp.makeConstraints({ (make) in
//                    make.edges.equalTo(cell.)
//                })
                
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
