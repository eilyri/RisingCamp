//
//  ViewController.swift
//  week2
//
//  Created by 권하은 on 2021/07/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var passwordField: UITextField!
    
    @IBAction func enterBtn(_ sender: Any) {
        if passwordField.text == "1111" {
            let controller = self.storyboard?.instantiateViewController(identifier: "TabBarController") as! TabBarController
            self.navigationController?.pushViewController(controller, animated: true)
            passwordField.text=""
        }
        else { return }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    
}

