//
//  SettingsViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/26.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var settingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        settingList = ["언어", "알림", "식당 등록", "공지사항", "고객센터", "도움말", "약관 및 정책", "접근권한 설정", "버전 정보", "로그아웃", "회원탈퇴"]
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as!
            SettingsTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
        cell.selectionStyle = .none
        cell.settingLabel.text = settingList[indexPath.row]
        cell.settingButton.isHidden = false
        
        if indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 9 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        if indexPath.row >= 8 {
            cell.settingButton.isHidden = true
        }
        if indexPath.row == 10 {
            cell.settingLabel.textColor = UIColor(hex: 0xaaaaaa)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 9 {
            showIndicator()
            LogoutDataManager().logout(viewController: self)
        }
    }
}

extension SettingsViewController {
    func didLogout() {
        self.dismissIndicator()
        UserDefaults.standard.removeObject(forKey: "UserIdKey")
        //UserDefaults.standard.removeObject(forKey: "jwtKey")
        JwtToken.token = ""
        let vc = SplashViewController()
        let navController = UINavigationController(rootViewController: vc)
        
        changeRootViewController(navController)
    }
    func failedToRequest(message: String) {
        dismissIndicator()
        presentAlert(message: message)
    }
}
