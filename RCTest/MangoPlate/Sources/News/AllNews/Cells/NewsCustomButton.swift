//
//  NewsCustomButton.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/23.
//

import UIKit

class NewsCustomButton: UIButton {
    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private let myIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var viewModel: NewsCustomButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: NewsCustomButtonViewModel) {
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
    
    public func configure(with viewModel: NewsCustomButtonViewModel){
        myTitleLabel.text = viewModel.title
        myTitleLabel.textColor = UIColor(cgColor: viewModel.borderColor)
        myIconView.image = UIImage(named: viewModel.imageName)?.withRenderingMode(.alwaysTemplate)
        
        addSubviews()
        
        layer.cornerRadius = 14
        layer.borderWidth = 0.8
        layer.borderColor = viewModel.borderColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myIconView.frame = CGRect(x: 8, y: 5, width: 21, height: 21)
        myTitleLabel.frame = CGRect(x: 33, y: 7, width: 40, height: 30)
        //myTitleLabel.center.y = self.frame.height / 2
        myTitleLabel.sizeToFit()
        self.frame.size = CGSize(width: 42 + myTitleLabel.frame.width , height: 30)
    }
}

struct NewsCustomButtonViewModel {
    var title: String
    var borderColor: CGColor
    var imageName: String
}
