//
//  ViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/14.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func kakaoLogin(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                let input = KakaoLoginInput(accessToken: oauthToken!.accessToken)
                KakaoLoginDataManager().kakaoLogin(input, viewController: self)
                
                print(oauthToken?.accessToken, "액세스 토큰")
                
                _ = oauthToken
            }
        }
        
    }
    
    @IBAction func EmailLoginButton(_ sender: Any) {
        navigationController?.pushViewController(EmailLoginViewController(), animated: true)
    }
    
    @IBAction func skipButton(_ sender: Any) {
        let vc = BaseTabBarController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
    }
}

extension SplashViewController {
    func didKakaoLogin(_ result: KakaoLoginResult){
        self.dismissIndicator()
        UserDefaults.standard.set(String(result.id!), forKey: "UserIdKey")
        //UserDefaults.standard.set(result.jwt, forKey: "jwtKey")
        JwtToken.token = result.jwt!
        let vc = BaseTabBarController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
    }
    
    func failedToRequest(message: String) {
        dismissIndicator()
        presentAlert(message: message)
    }
}
