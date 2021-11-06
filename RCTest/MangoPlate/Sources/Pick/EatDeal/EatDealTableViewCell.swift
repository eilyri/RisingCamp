//
//  EatDealTableViewCell.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/19.
//

import UIKit

class EatDealTableViewCell: UITableViewCell {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var costPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        gradientView.setGradient()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
