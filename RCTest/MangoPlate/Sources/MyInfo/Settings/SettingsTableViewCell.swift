//
//  SettingsTableViewCell.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/26.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var settingButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
