//
//  ViewController.swift
//  week5
//
//  Created by 권하은 on 2021/07/25.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet var signInButton : GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
    
    
}

