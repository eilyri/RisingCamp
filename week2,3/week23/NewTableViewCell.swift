//
//  NewTableViewCell.swift
//  week2
//
//  Created by 권하은 on 2021/07/09.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var newProfileImg: UIImageView!
    @IBOutlet weak var newNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
