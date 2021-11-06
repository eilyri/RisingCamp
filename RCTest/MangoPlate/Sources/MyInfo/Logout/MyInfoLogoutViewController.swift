//
//  MyInfoLogoutViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/21.
//

import UIKit

class MyInfoLogoutViewController: UIViewController {
    
    @IBAction func loginButton(_ sender: Any) {
        let vc = SplashViewController()
        let navController = UINavigationController(rootViewController: vc)
        
        changeRootViewController(navController)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
