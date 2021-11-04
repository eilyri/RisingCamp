//
//  FriendTableViewCell.swift
//  week2
//
//  Created by 권하은 on 2021/07/09.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendProfileImg: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
