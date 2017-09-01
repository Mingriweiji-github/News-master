//
//  VideoTopicCell.swift
//  News
//
//  Created by M_Li on 2017/9/1.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import Kingfisher
class VideoTopicCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var headerImgView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var concerBtn: UIButton!
    
    var videoTopic: WeiTouTiao?{
    
        didSet{
        
            playButton.kf.setBackgroundImage(with: URL(string:(videoTopic?.video_detail_info?.detail_video_large_image?.url!)!), for: .normal)
            titleLabel.text = String(describing: videoTopic?.title)
            if let user_info = videoTopic?.user_info {
                headerImgView.kf.setImage(with: URL(string:user_info.avatar_url!))
                nameLabel.text = user_info.name
            }
            
            if videoTopic?.comment_count != 0 {
                commentBtn.setTitle("评论", for: .normal)
            }else{
                commentBtn.setTitle(String(describing: videoTopic?.comment_count), for: .normal)
            }
            
            playCountLabel.text = videoTopic!.readCount! + "次播放"
            durationLabel.text = videoTopic?.video_duration
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func playAction(_ sender: Any) {
        
    }
    
    @IBAction func moreButtonAction(_ sender: Any) {
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
