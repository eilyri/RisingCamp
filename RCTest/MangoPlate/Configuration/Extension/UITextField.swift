//
//  UITextField.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/15.
//

import UIKit

extension UITextField {
    
    func setBottomBorder() {
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.mainGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.8)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
