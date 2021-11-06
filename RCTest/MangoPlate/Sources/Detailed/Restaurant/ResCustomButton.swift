//
//  ResCustomButton.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/20.
//

import UIKit

class ResCustomButton: UIButton {
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
    
    private var viewModel: ResCustomButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: ResCustomButtonViewModel) {
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
    
    public func configure(with viewModel: ResCustomButtonViewModel){
        myTitleLabel.text = viewModel.title
        myTitleLabel.textColor = viewModel.titleColor
        myIconView.image = UIImage(named: viewModel.imageName)
        
        addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myTitleLabel.frame = CGRect(x: 0, y: 42, width: 40, height: 15)
        myTitleLabel.sizeToFit()
        myIconView.frame = CGRect(x: self.frame.width / 2 - 18, y: 0, width: 36, height: 36)
        self.frame.size = CGSize(width: myTitleLabel.frame.width, height: 57)
    }
}

struct ResCustomButtonViewModel {
    let imageName: String
    let title: String
    let titleColor: UIColor
}

class MapCustomButton: UIButton {
    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hex: 0x3f3f3f)
        
        return label
    }()
    
    private let myIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var viewModel: MapCustomButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: MapCustomButtonViewModel) {
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
    
    public func configure(with viewModel: MapCustomButtonViewModel){
        myTitleLabel.text = viewModel.title
        myIconView.image = UIImage(named: viewModel.imageName)
        
        addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myTitleLabel.frame = CGRect(x: 0, y: 42, width: 40, height: 15)
        myTitleLabel.sizeToFit()
        myIconView.frame = CGRect(x: self.frame.width / 2 - 20, y: 0, width: 40, height: 40)
        self.frame.size = CGSize(width: myTitleLabel.frame.width, height: 57)
    }
}

struct MapCustomButtonViewModel {
    let imageName: String
    let title: String
}
