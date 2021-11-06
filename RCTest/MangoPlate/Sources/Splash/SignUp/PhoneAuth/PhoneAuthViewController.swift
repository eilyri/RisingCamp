//
//  PhoneAuthViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/18.
//

import UIKit

class PhoneAuthViewController: BaseViewController {

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton(_ sender: Any) {
        navigationController?.pushViewController(SetProfileViewController(), animated: true)
    }
    
    @IBOutlet weak var authTextField: UITextField!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainOrange
        
        authTextField.setBottomBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //presentAlert(message: "인증번호를 SMS로 전송했습니다")
    }

}
