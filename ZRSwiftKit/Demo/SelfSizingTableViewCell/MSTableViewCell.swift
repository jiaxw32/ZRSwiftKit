//
//  MSTableViewCell.swift
//  MSTabelViewDemo
//
//  Created by jiaxw-mac on 2017/8/28.
//  Copyright © 2017年 jiaxw-mac. All rights reserved.
//

import UIKit

class MSTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    
    @IBOutlet weak var avatarImageView:UIImageView!
    
    @IBOutlet weak var bioLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
