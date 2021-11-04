//
//  TextTableViewCell.swift
//  week2
//
//  Created by 권하은 on 2021/07/08.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var myProfileImg: UIImageView!
    
    @IBOutlet weak var myNameLabel: UILabel!
    
    @IBOutlet weak var myTextLabel: UILabel!
    @IBOutlet weak var myDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
