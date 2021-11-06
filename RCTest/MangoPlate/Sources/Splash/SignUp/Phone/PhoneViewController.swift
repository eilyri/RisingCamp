//
//  PhoneAuthViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/18.
//

import UIKit

class PhoneViewController: BaseViewController {
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton(_ sender: Any) {
        UserDefaults.standard.set(phoneTextField.text, forKey: "phoneKey")
        
        navigationController?.pushViewController(PhoneAuthViewController(), animated: true)
    }
    
    @objc func phoneTextFieldDidChange(_ sender: Any?) {
        if phoneTextField.text != "" {
            nextButton.backgroundColor = .mainOrange
            nextButton.isEnabled = true
        }
        else {
            nextButton.backgroundColor = .mainGray
            nextButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneTextField.setBottomBorder()
        nextButton.isEnabled = true
        
        phoneTextField.addTarget(self, action: #selector(phoneTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navTitleLeftAlign(title: "휴대폰 번호 인증")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
