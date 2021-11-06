//
//  NewsViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/16.
//

import UIKit

class NewsViewController: BaseViewController {
    
    let allnewsVC = AllNewsViewController()
    
    @IBOutlet weak var newsSegmentedControl: UISegmentedControl!
    let segmentIndicator: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.mainOrange
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customNavBarLeft(title: "전체지역")
        setSegmentedControl()
        setUp()
    }
    
    func setUp() {
        addChild(allnewsVC)
        
        self.view.addSubview(allnewsVC.view)
        
        allnewsVC.didMove(toParent: self)
        
        allnewsVC.view.frame = CGRect(x: 0, y: 46, width: self.view.bounds.width, height: self.view.bounds.height - 46)
        allnewsVC.view.isHidden = false
    }

    func setSegmentedControl() {
        newsSegmentedControl.backgroundColor = .clear
        newsSegmentedControl.tintColor = .clear
        newsSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Regular", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.mainGray], for: .normal)
        newsSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Regular", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
        self.view.addSubview(segmentIndicator)
        segmentIndicator.snp.makeConstraints{ (make) in
            make.top.equalTo(newsSegmentedControl.snp.bottom).offset(3)
            make.height.equalTo(3)
            make.width.equalTo(newsSegmentedControl.frame.width / 3)
            make.centerX.equalTo(newsSegmentedControl.snp.centerX).dividedBy(newsSegmentedControl.numberOfSegments)
        }
        newsSegmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        newsSegmentedControl.setBackgroundImage(UIImage(named: "rectangle"), for: .normal, barMetrics: .default)
        newsSegmentedControl.setDividerImage(UIImage(named: "divider"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let numberOfSegments = CGFloat(sender.numberOfSegments)
        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
        
        segmentIndicator.snp.remakeConstraints { (make) in
            make.top.equalTo(sender.snp.bottom).offset(3)
            make.height.equalTo(3)
            make.width.equalTo(sender.frame.width / 3)
            make.centerX.equalTo(sender.snp.centerX).dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedIndex - 1.0) * 2.0))
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
        allnewsVC.view.isHidden = true
        
        if newsSegmentedControl.selectedSegmentIndex == 0 {
            allnewsVC.view.isHidden = false
        }
        
    }

}
