//
//  NewFriendView.swift
//  week2
//
//  Created by 권하은 on 2021/07/09.
//

import Foundation
import UIKit

protocol AddFriendDelegate {
    func addFriend(friendName: String)
}

class NewFriendView : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var friendTable: UITableView!
    
    var newFriends = ["친구6", "친구b", "친구d", "친구e"]
    
    var delegate: AddFriendDelegate?
    
    var selected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendTable.rowHeight = UITableView.automaticDimension
        friendTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        friendTable.delegate = self
        friendTable.dataSource = self
        
        if UserDefaults.standard.stringArray(forKey: "SavedNew") != nil {
            newFriends = UserDefaults.standard.stringArray(forKey: "SavedNew")!
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //friendTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewTableViewCell", for: indexPath) as! NewTableViewCell
        let newName = newFriends[indexPath.row]
        cell.newNameLabel.text = newName
        cell.newProfileImg.image = UIImage(named: newName)
        cell.addButton.addTarget(self, action: #selector(addtoView), for: .touchUpInside)
        return cell
    }
    
    @objc func addtoView(sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: friendTable)
        guard let indexpath = friendTable.indexPathForRow(at: point) else {return}
        selected = newFriends[indexpath.row]
        print("addView " + selected)
        delegate?.addFriend(friendName: selected)
        newFriends.remove(at: indexpath.row)
        UserDefaults.standard.set(newFriends, forKey: "SavedNew")
        friendTable.beginUpdates()
        friendTable.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
        friendTable.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "삭제") { (action, view, nil) in
            self.newFriends.remove(at: indexPath.row)
            UserDefaults.standard.set(self.newFriends, forKey: "SavedNew")
            self.friendTable.reloadData()
        }
        action.backgroundColor = .red
        return action
    }
}
