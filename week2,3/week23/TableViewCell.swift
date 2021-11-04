//
//  TableViewCell.swift
//  week2
//
//  Created by 권하은 on 2021/07/13.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var tableLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
