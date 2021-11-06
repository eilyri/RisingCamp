//
//  EmailSignUpViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/17.
//

import UIKit

class EmailSignUpViewController: BaseViewController {
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func closeButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    var userEmail: String = ""
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pwmessageLabel: UILabel!
    
    @IBOutlet weak var passwordvalidate: UITextField!
    @IBOutlet weak var pwvmessageLabel: UILabel!
    
    @IBOutlet weak var emailCertifyButton: UIButton!
    @IBAction func emailCertifyButton(_ sender: Any) {
        showIndicator()
        EmailSignUpDataManager().usersemails(email: emailTextField.text!, viewController: self)
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton(_ sender: Any) {
        if (isEmailCertificated == true) && (isPassword(myPassword: passwordTextField.text!) == true) && (isPasswordMatch() == true) {
            UserDefaults.standard.set(passwordTextField.text, forKey: "passwordKey")
            navigationController?.pushViewController(PhoneViewController(), animated: true)
        }
        if isEmailCertificated == false {
            self.presentAlert(message: "이메일 인증이 완료되지 않았습니다.")
        }
        
    }
    
    var isEmailCertificated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        passwordvalidate.setBottomBorder()
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        passwordvalidate.addTarget(self, action: #selector(pwvDidChange(_:)), for: .editingChanged)
        
        view.backgroundColor = .mainGray
        isEmailCertificated = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    @objc func emailTextFieldDidChange(_ sender: Any?) {
        isEmailCertificated = false
        messageLabel.text = ""
        emailTextField.layer.shadowColor = UIColor.mainGray.cgColor
        if emailTextField.text != "" {
            emailCertifyButton.backgroundColor = .mainOrange
            emailCertifyButton.tintColor = .white
            emailCertifyButton.isEnabled = true
        }
        else {
            emailCertifyButton.backgroundColor = .mainGray
            emailCertifyButton.tintColor = .white
            emailCertifyButton.isEnabled = false
        }
    }
    
    func isEmail(testStr: String) {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        if emailTest.evaluate(with: testStr) {
            messageLabel.text = ""
            self.presentAlert(message: "요청하신 이메일 주소로 인증 메일을 전송했습니다.")
            isEmailCertificated = true
            UserDefaults.standard.set(testStr, forKey: "emailKey")
        }
        else  {
            messageLabel.text = "잘못된 메일주소입니다. 다시 입력해주세요."
            emailTextField.layer.shadowColor = UIColor.mainOrange.cgColor
        }
    }
    
    func emailCertify(result: Bool) {
        dismissIndicator()
        if result == true {
            isEmail(testStr: emailTextField.text!)
        }
        else {
            messageLabel.text = "이미 가입된 메일주소 입니다."
            emailTextField.layer.shadowColor = UIColor.mainOrange.cgColor
        }
    }
    
    @objc func passwordTextFieldDidChange(_ sender: Any?) {
        pwmessageLabel.text = ""
        passwordTextField.layer.shadowColor = UIColor.mainGray.cgColor
        if passwordTextField.text != "" {
            view.backgroundColor = .mainOrange
            nextButton.isEnabled = true
        }
        else {
            view.backgroundColor = .mainGray
            nextButton.isEnabled = false
        }
    }
    
    func isPassword(myPassword: String) -> Bool {
        let passwordreg = ("^(?=.*[A-Za-z])(?=.*[0-9]).{6,12}$")
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        if !passwordTest.evaluate(with: myPassword) {
            pwmessageLabel.text = "비밀번호를 다시 확인 해주세요"
            passwordTextField.layer.shadowColor = UIColor.mainOrange.cgColor
        }
        
        return passwordTest.evaluate(with: myPassword)
    }
    
    func isPasswordMatch() -> Bool {
        if passwordTextField.text == passwordvalidate.text {
            return true
        }
        pwvmessageLabel.text = "비밀번호가 일치 하지 않습니다"
        passwordvalidate.layer.shadowColor = UIColor.mainOrange.cgColor
        return false
    }
    
    @objc func pwvDidChange(_ sender: Any?){
        pwvmessageLabel.text = ""
        passwordvalidate.layer.shadowColor = UIColor.mainGray.cgColor
    }

}
