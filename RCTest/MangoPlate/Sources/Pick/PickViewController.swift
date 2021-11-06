//
//  PickViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/15.
//

import UIKit

class PickViewController: BaseViewController {

    let eatDealVC = EatDealViewController()
    let storyVC = StoryViewController()
    let topListVC = TopListViewController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let segmentIndicator: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.mainOrange
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setSegmentedControl()
        setUp()
    }
    
    func setUp() {
        addChild(eatDealVC)
        addChild(storyVC)
        addChild(topListVC)
        
        self.view.addSubview(eatDealVC.view)
        self.view.addSubview(storyVC.view)
        self.view.addSubview(topListVC.view)
        
        eatDealVC.didMove(toParent: self)
        storyVC.didMove(toParent: self)
        topListVC.didMove(toParent: self)
        
        //eatDealVC.view.frame = self.view.bounds
        //storyVC.view.frame = self.view.bounds
        //topListVC.view.frame = self.view.bounds
        eatDealVC.view.frame = CGRect(x: 0, y: 104, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        storyVC.view.frame = CGRect(x: 0, y: 104, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        topListVC.view.frame = CGRect(x: 0, y: 104, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        
        eatDealVC.view.isHidden = false
        storyVC.view.isHidden = true
        topListVC.view.isHidden = true
    }
    
    func setSegmentedControl() {
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.mainGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
        self.view.addSubview(segmentIndicator)
        segmentIndicator.snp.makeConstraints{ (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(3)
            make.height.equalTo(3)
            make.width.equalTo(segmentedControl.frame.width / 3)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
        }
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        segmentedControl.setBackgroundImage(UIImage(named: "rectangle"), for: .normal, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(named: "divider"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let numberOfSegments = CGFloat(segmentedControl.numberOfSegments)
        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
        
        segmentIndicator.snp.remakeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(3)
            make.height.equalTo(3)
            make.width.equalTo(segmentedControl.frame.width / 3)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedIndex - 1.0) * 2.0))
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
        eatDealVC.view.isHidden = true
        storyVC.view.isHidden = true
        topListVC.view.isHidden = true
        
        if segmentedControl.selectedSegmentIndex == 0 {
            eatDealVC.view.isHidden = false
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            storyVC.view.isHidden = false
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            topListVC.view.isHidden = false
        }
    }

}
