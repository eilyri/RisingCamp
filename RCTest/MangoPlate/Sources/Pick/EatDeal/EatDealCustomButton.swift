//
//  EatDealCustomButton.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/24.
//

import UIKit

class MyEatDealCustomButton: UIButton {
    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .mainOrange
        
        return label
    }()
    
    private let myIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        return imageView
    }()
    
    private var viewModel: MyEatDealButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: MyEatDealButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addSubviews()
        configure(with: viewModel)
    }
    
    private func addSubviews() {
        guard !myTitleLabel.isDescendant(of: self) else {
            return
        }
        addSubview(myTitleLabel)
        addSubview(myIconView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: MyEatDealButtonViewModel){
        myTitleLabel.text = viewModel.title
        
        addSubviews()
        
        layer.cornerRadius = 16
        layer.borderWidth = 0.8
        layer.borderColor = UIColor.mainOrange.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myTitleLabel.frame = CGRect(x: 12, y: 7, width: 40, height: 30)
        myTitleLabel.sizeToFit()
        myIconView.frame = CGRect(x: myTitleLabel.frame.width + 19, y: 13, width: 10, height: 6)
        //myTitleLabel.center.y = self.frame.height / 2
        
        self.frame.size = CGSize(width: 39 + myTitleLabel.frame.width , height: 30)
    }
}

struct MyEatDealButtonViewModel {
    let title: String
}
