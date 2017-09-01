//
//  VideoTopicCell.swift
//  News
//
//  Created by M_Li on 2017/9/1.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class VideoTopicCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var headerImgView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var concerBtn: UIButton!
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
