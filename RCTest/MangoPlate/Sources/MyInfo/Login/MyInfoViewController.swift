//
//  MyInfoViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/16.
//

import UIKit

class MyInfoViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var sectionList = [["이벤트"], ["구매한 EAT딜", "EAT딜 입고알림"], ["타임라인", "", "가고싶다", "마이리스트", "북마크", "내가 등록한 식당"], ["설정"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        infoTableView.register(UINib(nibName: "TimelineTableViewCell", bundle: nil), forCellReuseIdentifier: "TimelineTableViewCell")

        infoTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    override func viewDidLayoutSubviews() {
        self.changeTableHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
        let userId = Int(UserDefaults.standard.string(forKey: "UserIdKey")!)!
        GetUserInfoDataManager().getUserInfo(userId: userId, viewController: self)
    }
}

extension MyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func changeTableHeight() {
        self.tableViewHeight.constant = self.infoTableView.contentSize.height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as! InfoTableViewCell
        cell.infoImgView.image = UIImage(named: sectionList[indexPath.section][indexPath.row])
        cell.infoLabel.text = sectionList[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        
        if (indexPath.section == 2) && (indexPath.row == 0) || (indexPath.section == 3) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
        }
        
        if (indexPath.section == 2) && (indexPath.row == 1) {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
            cell1.selectionStyle = .none
            return cell1
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 3) && (indexPath.row == 0) {
            navigationController?.pushViewController(SettingsViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 12))
        view.backgroundColor = UIColor(hex: 0xEEEEEE)
        return view
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            scrollView.contentOffset.y = 0
        }
        else if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
}

extension MyInfoViewController {
    func didRetrieveUserInfo(_ result: GetUserInfoResult) {
        dismissIndicator()
        let url = URL(string: result.profileImage ?? "")
        if url != nil {
            let data = try? Data(contentsOf: url!)
            profileImage.image = UIImage(data: data!)
        }
        nicknameLabel.text = result.nickname ?? ""
        followerLabel.text = String(result.followers ?? 0)
        followingLabel.text = String(result.followings ?? 0)
    }
    func failedToRequest(message: String) {
        dismissIndicator()
        presentAlert(message: message)
    }
}
