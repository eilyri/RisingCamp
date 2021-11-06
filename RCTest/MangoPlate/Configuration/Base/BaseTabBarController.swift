//
//  BaseTabBarController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/15.
//

import UIKit
import CoreLocation

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    var locationManager: CLLocationManager!
    
    let searchViewController = SearchViewController()
    let searchTabBarItem = UITabBarItem(title: "맛집찾기", image: UIImage(named: "searchitem"), tag: 0)
    
    let pickViewController = PickViewController()
    let pickTabBarItem = UITabBarItem(title: "망고픽", image: UIImage(named: "pickitem"), tag: 1)
    
    let plusViewController = PlusViewController()
    let plusTabBarItem = UITabBarItem(title: "+", image: nil, tag: 2)
    
    let newsViewController = NewsViewController()
    let newsTabBarItem = UITabBarItem(title: "소식", image: UIImage(named: "newsitem"), tag: 3)
    
    let myInfoViewController = MyInfoViewController()
    let myInfoTabBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "myinfoitem"), tag: 4)
    
    let myInfoLogoutViewController = MyInfoLogoutViewController()
    let myInfoLogoutTabBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "myinfoitem"), tag: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.mainOrange
        self.tabBar.unselectedItemTintColor = UIColor.mainGray
        self.tabBar.isTranslucent = false
        
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        let pickNavController = UINavigationController(rootViewController: pickViewController)
        let plusNavController = UINavigationController(rootViewController: plusViewController)
        let newsNavController = UINavigationController(rootViewController: newsViewController)
        let myInfoNavController = UINavigationController(rootViewController: myInfoViewController)
        let myInfoLogoutNavController = UINavigationController(rootViewController: myInfoLogoutViewController)
        
        searchTabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 16, bottom: 15, right: 16)
        pickTabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 15, bottom: 13, right: 15)
        newsTabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 18, bottom: 11, right: 18)
        myInfoTabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 16, bottom: 15, right: 16)
        myInfoLogoutTabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 16, bottom: 15, right: 16)
        
        searchNavController.tabBarItem = searchTabBarItem
        pickNavController.tabBarItem = pickTabBarItem
        plusNavController.tabBarItem = plusTabBarItem
        newsNavController.tabBarItem = newsTabBarItem
        myInfoNavController.tabBarItem = myInfoTabBarItem
        myInfoLogoutNavController.tabBarItem = myInfoLogoutTabBarItem
        
        if JwtToken.token != "" {
            self.viewControllers = [searchNavController, pickNavController, plusNavController, newsNavController, myInfoNavController]
        }
        else {
            self.viewControllers = [searchNavController, pickNavController, plusNavController, newsNavController, myInfoLogoutNavController]
        }
        
        self.delegate = self
        
        setUpMiddleButton()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    func setUpMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 20, y: 5, width: 40, height: 40))
        
        middleButton.setBackgroundImage(UIImage(named: "centerbutton"), for: .normal)
        //middleButton.layer.shadowColor = UIColor.black.cgColor
        //middleButton.layer.shadowOpacity = 0.1
        //middleButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        //self.selectedIndex = 2
        let plusNavController = UINavigationController(rootViewController: plusViewController)
        plusNavController.modalPresentationStyle = .fullScreen
        plusNavController.modalTransitionStyle = .crossDissolve
        plusNavController.navigationController?.setNavigationBarHidden(true, animated: false)
        present(plusNavController, animated: true, completion: nil)
    }
    
    func toPick() {
        self.selectedIndex = 1
    }
    
}

extension BaseTabBarController: CLLocationManagerDelegate {
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            getLocationUsagePermission()
            self.locationManager.startUpdatingLocation()
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS 권한 요청 거부됨")
            getLocationUsagePermission()
        default:
            print("GPS: Default")
        }
    }
}
