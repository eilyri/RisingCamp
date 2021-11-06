//
//  InfoTableViewCell.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/21.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoImgView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
