//
//  NewsButtonTableViewCell.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/23.
//

import UIKit

class NewsButtonTableViewCell: UITableViewCell {
    
    var buttonSelected = [String]()
    
    let goodButton: NewsCustomButton = {
        let button = NewsCustomButton(frame: CGRect(x: 0, y: 9, width: 80, height: 32))
        return button
    }()
    let okButton: NewsCustomButton = {
        let button = NewsCustomButton(frame: CGRect(x: 0, y: 9, width: 80, height: 32))
        return button
    }()
    let badButton: NewsCustomButton = {
        let button = NewsCustomButton(frame: CGRect(x: 0, y: 9, width: 80, height: 32))
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setButtons()
        buttonSelected = ["맛있다!", "괜찮다", "별로"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setButtons() {
        self.addSubview(goodButton)
        goodButton.frame = CGRect(x: 15, y: 15, width: 0, height: 0)
        let viewModel = NewsCustomButtonViewModel(title: "맛있다!", borderColor: UIColor.mainOrange.cgColor, imageName: "good")
        goodButton.configure(with: viewModel)
        goodButton.tintColor = .mainOrange
        goodButton.backgroundColor = UIColor(hex: 0xFBEADA)
        
        self.addSubview(okButton)
        okButton.frame = CGRect(x: 105, y: 15, width: 0, height: 0)
        let viewModel1 = NewsCustomButtonViewModel(title: "괜찮다", borderColor: UIColor.mainOrange.cgColor, imageName: "ok")
        okButton.configure(with: viewModel1)
        okButton.tintColor = .mainOrange
        okButton.backgroundColor = UIColor(hex: 0xFBEADA)
        
        self.addSubview(badButton)
        badButton.frame = CGRect(x: 190, y: 15, width: 0, height: 0)
        let viewModel2 = NewsCustomButtonViewModel(title: "별로", borderColor: UIColor.mainOrange.cgColor, imageName: "bad")
        badButton.configure(with: viewModel2)
        badButton.tintColor = .mainOrange
        badButton.backgroundColor = UIColor(hex: 0xFBEADA)
    }
    
}
