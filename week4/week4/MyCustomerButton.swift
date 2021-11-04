//
//  MyCustomerButton.swift
//  week4
//
//  Created by 권하은 on 2021/07/23.
//

import UIKit

struct MyCustomerButtonViewModel {
    let myCustomerText: String
    let myProgressWidth: Int
}

class MyCustomerButton: UIButton {
    private let myCustomerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Verdana-Bold", size: 24)
        return label
    }()
    
    private let progressView: MyProgressView = {
        let pgView = MyProgressView()
        return pgView
    }()
        
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(myCustomerLabel)
        addSubview(progressView)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with viewModel: MyCustomerButtonViewModel) {
        myCustomerLabel.text = viewModel.myCustomerText
        progressView.configureView(barwidth: CGFloat(viewModel.myProgressWidth))
    }
    
    func getText() -> String {
        return myCustomerLabel.text!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myCustomerLabel.frame = CGRect(x: 26, y: -55, width: frame.size.width, height: frame.size.height)
    }
}

