//
//  PlusCustomButton.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/24.
//

import UIKit

class PlusCustomButton: UIButton {
    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 23, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private let myIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var viewModel: PlusCustomButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: PlusCustomButtonViewModel) {
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
    
    public func configure(with viewModel: PlusCustomButtonViewModel){
        myTitleLabel.text = viewModel.title
        myIconView.image = UIImage(named: viewModel.imgname)
        
        addSubviews()
        
        layer.cornerRadius = 16
        layer.borderWidth = 0.8
        layer.borderColor = UIColor.mainOrange.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myIconView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        myTitleLabel.frame = CGRect(x: 50, y: 3, width: 40, height: 30)
        myTitleLabel.sizeToFit()
        
        self.frame.size = CGSize(width: 50 + myTitleLabel.frame.width , height: 35)
    }
}

struct PlusCustomButtonViewModel {
    let title: String
    let imgname: String
}
