//
//  RankingViewController.swift
//  week4
//
//  Created by 권하은 on 2021/07/24.
//

import Foundation
import UIKit

class RankingViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTable: UITableView!
    
    @IBAction func goToRootButton(_ sender: Any) {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    var scoreArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self
        myTable.dataSource = self
        myTable.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        if UserDefaults.standard.array(forKey: "SavedScore") != nil {
            scoreArray = UserDefaults.standard.array(forKey: "SavedScore") as! [Int]
        }
        
        scoreArray.sort(by: > )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingCell", for: indexPath) as! RankingCell
        cell.rankLabel.text = String(indexPath.row + 1)
        cell.rankScoreLabel.text = String(scoreArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
