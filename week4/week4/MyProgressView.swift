//
//  MyProgressView.swift
//  week4
//
//  Created by 권하은 on 2021/07/23.
//

import UIKit

class MyProgressView: UIView {
    @IBOutlet weak var myProgressBar: UIView!
    var barWidth = 120
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 8, y: 1, width: 120, height: 20))
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "MyProgressView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func configureView(barwidth: CGFloat) {
        myProgressBar.frame = CGRect(x: 1, y: 1, width: barwidth, height: 18)
        myProgressBar.setGradient()
    }
}

extension UIView {
    func setGradient(){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 1, green: 0, blue: 0.1378505826, alpha: 1).cgColor, #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1).cgColor, #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor]
        //gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}

