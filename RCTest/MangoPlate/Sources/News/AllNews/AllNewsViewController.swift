//
//  AllNewsViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/21.
//

import UIKit

class AllNewsViewController: UIViewController {
    var buttonSelected = [String]()
    
    var news = [NewsReviewResult]()
    var newsList = [NewsReviewResult]()
    
    var reviewPictureList = [String]()
    
    @IBOutlet weak var allnewsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSelected = ["맛있다!", "괜찮다", "별로"]
        
        // Do any additional setup after loading the view.
        allnewsTableView.delegate = self
        allnewsTableView.dataSource = self
        allnewsTableView.backgroundColor = UIColor(hex: 0xeeeeee)
        allnewsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        allnewsTableView.register(UINib(nibName: "NewsButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsButtonTableViewCell")
        allnewsTableView.separatorStyle = .none
        allnewsTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
        NewsReviewDataManager().getReview(evaluation: "", viewController: self)
        /*if let myData = UserDefaults.standard.value(forKey: "newsListKey") as? Data {
            newsList = try! PropertyListDecoder().decode([NewsReviewResult].self, from: myData)
        }*/
    }
}


extension AllNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsButtonTableViewCell") as! NewsButtonTableViewCell
            cell.selectionStyle = .none
            cell.goodButton.addTarget(self, action: #selector(goodButtonAction(_:)), for: .touchUpInside)
            cell.okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
            cell.badButton.addTarget(self, action: #selector(badButtonAction(_:)), for: .touchUpInside)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
            cell.backgroundColor = UIColor(hex: 0xeeeeee)
            cell.selectionStyle = .none
            
            if newsList.count > 0 {
                
                if newsList[indexPath.row - 1].profileImage == nil {
                    cell.profileImageView.image = UIImage(named: "profile")
                }
                else {
                    let url = URL(string: newsList[indexPath.row - 1].profileImage!)
                    let data = try? Data(contentsOf: url!)
                    cell.profileImageView.image = UIImage(data: data!)
                }
                
                cell.nicknameLabel.text = newsList[indexPath.row - 1].nickname
                cell.reviewCountLabel.text = String(newsList[indexPath.row - 1].reviewCount ?? 0)
                cell.followerCountLabel.text = String(newsList[indexPath.row - 1].followerCount ?? 0)
                cell.evaluationImage.image = UIImage(named: newsList[indexPath.row - 1].evaluation!)
                cell.evaluationLabel.text = newsList[indexPath.row - 1].evaluation
                cell.likeCountLabel.text = String(newsList[indexPath.row - 1].likeCount ?? 0)
                cell.commentCountLabel.text = String(newsList[indexPath.row - 1].commentCount ?? 0)
                cell.dateLabel.text = newsList[indexPath.row - 1].date
                cell.reviewLabel.text = newsList[indexPath.row - 1].content
                cell.reviewLabel.sizeToFit()
                cell.pictureString = newsList[indexPath.row - 1].reviewImage ?? ""
                cell.areaInfoLabel.text = "\(newsList[indexPath.row - 1].restaurantName!) - \(newsList[indexPath.row - 1].area!)"
                cell.pictureCollectionView.reloadData()
            }
            return cell
        }
        
    }
    
}

extension AllNewsViewController {
    func didRetrieveNewsReview(_ result: [NewsReviewResult]) {
        self.dismissIndicator()
        if let myData = UserDefaults.standard.value(forKey: "newsListKey") as? Data {
            newsList = try! PropertyListDecoder().decode([NewsReviewResult].self, from: myData)
        }
        self.allnewsTableView.reloadData()
    }
    func failedToRequest(message: String) {
        dismissIndicator()
        presentAlert(message: message)
    }
    
    @objc func goodButtonAction(_ sender: NewsCustomButton) {
        if buttonSelected.contains("맛있다!") {
            let index = buttonSelected.firstIndex(of: "맛있다!")!
            buttonSelected.remove(at: index)
            if buttonSelected.count == 0 {
                presentAlert(message: "모두 해제할 수 없어요")
                buttonSelected.append("맛있다!")
            }
            else {
                sender.backgroundColor = .white
                sender.configure(with: NewsCustomButtonViewModel(title: "맛있다!", borderColor: UIColor(hex: 0xd0d0d0).cgColor, imageName: "good"))
                sender.tintColor = UIColor(hex: 0xd0d0d0)
            }
        }
        else {
            buttonSelected.append("맛있다!")
            sender.backgroundColor = UIColor(hex: 0xFBEADA)
            sender.configure(with: NewsCustomButtonViewModel(title: "맛있다!", borderColor: UIColor.mainOrange.cgColor, imageName: "good"))
            sender.tintColor = .mainOrange
        }
        
        var string = ""
        if buttonSelected.contains("맛있다!") {
            string += "맛있다!,"
        }
        
        if buttonSelected.contains("괜찮다") {
            string += "괜찮다,"
        }
        
        if buttonSelected.contains("별로") {
            string += "별로,"
        }
        
        showIndicator()
        NewsReviewDataManager().getReview(evaluation: string, viewController: self)
    }
    
    @objc func okButtonAction(_ sender: NewsCustomButton) {
        if buttonSelected.contains("괜찮다") {
            let index = buttonSelected.firstIndex(of: "괜찮다")!
            buttonSelected.remove(at: index)
            if buttonSelected.count == 0 {
                presentAlert(message: "모두 해제할 수 없어요")
                buttonSelected.append("괜찮다")
            }
            else {
                sender.backgroundColor = .white
                sender.configure(with: NewsCustomButtonViewModel(title: "괜찮다", borderColor: UIColor(hex: 0xd0d0d0).cgColor, imageName: "ok"))
                sender.tintColor = UIColor(hex: 0xd0d0d0)
            }
        }
        else {
            buttonSelected.append("괜찮다")
            sender.backgroundColor = UIColor(hex: 0xFBEADA)
            sender.configure(with: NewsCustomButtonViewModel(title: "괜찮다", borderColor: UIColor.mainOrange.cgColor, imageName: "ok"))
            sender.tintColor = .mainOrange
        }
        var string = ""
        if buttonSelected.contains("맛있다!") {
            string += "맛있다!,"
        }
        
        if buttonSelected.contains("괜찮다") {
            string += "괜찮다,"
        }
        
        if buttonSelected.contains("별로") {
            string += "별로,"
        }
        
        showIndicator()
        NewsReviewDataManager().getReview(evaluation: string, viewController: self)
    }
    
    @objc func badButtonAction(_ sender: NewsCustomButton) {
        if buttonSelected.contains("별로") {
            let index = buttonSelected.firstIndex(of: "별로")!
            buttonSelected.remove(at: index)
            if buttonSelected.count == 0 {
                presentAlert(message: "모두 해제할 수 없어요")
                buttonSelected.append("별로")
            }
            else {
                sender.backgroundColor = .white
                sender.configure(with: NewsCustomButtonViewModel(title: "별로", borderColor: UIColor(hex: 0xd0d0d0).cgColor, imageName: "bad"))
                sender.tintColor = UIColor(hex: 0xd0d0d0)
            }
        }
        else {
            buttonSelected.append("별로")
            sender.backgroundColor = UIColor(hex: 0xFBEADA)
            sender.configure(with: NewsCustomButtonViewModel(title: "별로", borderColor: UIColor.mainOrange.cgColor, imageName: "bad"))
            sender.tintColor = .mainOrange
        }
        var string = ""
        if buttonSelected.contains("맛있다!") {
            string += "맛있다!,"
        }
        
        if buttonSelected.contains("괜찮다") {
            string += "괜찮다,"
        }
        
        if buttonSelected.contains("별로") {
            string += "별로,"
        }
        
        showIndicator()
        NewsReviewDataManager().getReview(evaluation: string, viewController: self)
    }

}


