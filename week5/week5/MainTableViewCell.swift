//
//  MainTableViewCell.swift
//  week5
//
//  Created by 권하은 on 2021/07/29.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var isAble: UILabel!
    @IBOutlet weak var statNameLabel: UILabel!
    @IBOutlet weak var statAddrLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
