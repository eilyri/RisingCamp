//
//  TabItems.swift
//  week2
//
//  Created by 권하은 on 2021/07/06.
//

import Foundation
import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [friendCell]()
}

struct friendCell {
    var friendName = String()
    var isMarked = Bool()
}

class FirstItem : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTable: UITableView!
    
    var tableViewData = [cellData(opened: false, title: "", sectionData: []), cellData(opened: true, title: "추천친구", sectionData: [friendCell(friendName: "새로운 친구를 만나보세요!", isMarked: false)]), cellData(opened: true, title: "친구", sectionData: [friendCell(friendName: "친구1", isMarked: false), friendCell(friendName: "친구2", isMarked: false), friendCell(friendName: "친구3", isMarked: false), friendCell(friendName: "친구4", isMarked: false), friendCell(friendName: "친구5", isMarked: false), friendCell(friendName: "친구7", isMarked: false), friendCell(friendName: "친구8", isMarked: false), friendCell(friendName: "친구9", isMarked: false), friendCell(friendName: "친구a", isMarked: false), friendCell(friendName: "친구c", isMarked: false)])]

    var markedFriends = cellData(opened: true, title: "즐겨찾기", sectionData: [])
    
    var count: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewCellNib = UINib(nibName: "TableViewCell" , bundle: nil)
        
        self.myTable.register(tableViewCellNib, forCellReuseIdentifier: "TableViewCell")
        
        
        self.myTable.rowHeight = UITableView.automaticDimension
        myTable.delegate = self
        myTable.dataSource = self
        myTable.tableFooterView = UIView(frame: CGRect.zero)
        
        self.myTable.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.myTable.separatorStyle = .singleLine
        
        /*if UserDefaults.standard.stringArray(forKey: "SavedFriend") != nil {
            friendViewData[0].sectionData = UserDefaults.standard.array(forKey: "SavedFriend")!
        }*/
        
        print("fviewDidLoad")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var newFriends = ["친구6", "친구b", "친구d", "친구e"]
        print("fviewWillAppear")
        if UserDefaults.standard.stringArray(forKey: "SavedNew") != nil {
            newFriends = UserDefaults.standard.stringArray(forKey: "SavedNew")!
        }
        
        count = newFriends.count
        
        print("count ", count)
        self.myTable.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !tableViewData[section].opened {
            return 1
        }
        return tableViewData[section].sectionData.count + 1
    }
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath)
            return cell
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
                cell.tableLabel.text = tableViewData[indexPath.section].title
                cell.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
                cell.expandButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
                cell.expandButton.tag = indexPath.section
                cell.selectionStyle = .none
                if tableViewData[indexPath.section].opened == true {
                    cell.expandButton.setImage(UIImage(named: "arrowuppng"), for: .normal)
                }
                else if tableViewData[indexPath.section].opened == false {
                    cell.expandButton.setImage(UIImage(named: "arrowdown"), for: .normal)
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                }
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
                cell.newCountLabel.text = String(count)
                
                return cell
            }
        }
        else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
                cell.tableLabel.text = tableViewData[indexPath.section].title
                cell.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
                if tableViewData[indexPath.section].opened == true {
                    cell.expandButton.setImage(UIImage(named: "arrowuppng"), for: .normal)
                }
                else if tableViewData[indexPath.section].opened == false {
                    cell.expandButton.setImage(UIImage(named: "arrowdown"), for: .normal)
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                    if indexPath.section == tableViewData.count - 1 {
                        cell.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
                    }
                    
                }
                cell.expandButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
                cell.expandButton.tag = indexPath.section
                cell.selectionStyle = .none
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
                let nameString = tableViewData[indexPath.section].sectionData[indexPath.row - 1].friendName
                cell.friendNameLabel.text = nameString
                cell.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
                if indexPath.row == tableViewData[indexPath.section].sectionData.count {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                    
                }
                cell.friendProfileImg.image = UIImage(named: nameString)
                return cell
            }
        }
    }
    
    //MARK: handleExpandClose()
    @objc func handleExpandClose(button: UIButton) {
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in tableViewData[section].sectionData.indices {
            print(0, row)
            let indexPath = IndexPath(row: row+1, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = tableViewData[section].opened
        tableViewData[section].opened = !isExpanded
        
        if isExpanded {
            myTable.deleteRows(at: indexPaths, with: .none)
        }
        else {
            myTable.insertRows(at: indexPaths, with: .none)
        }
        
        myTable.reloadData()
    }
    
    //MARK: Leading Swipe Action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section >= 2, indexPath.row != 0 {
            let markAction : UIContextualAction
            let markStatus = tableViewData[indexPath.section].sectionData[indexPath.row - 1].isMarked
            let friendName = tableViewData[indexPath.section].sectionData[indexPath.row - 1 ].friendName
            var index1 = 0
            var index2 = 0
            if markStatus == true {
                markAction = UIContextualAction(style: .normal, title: "제거"){
                    (action, view, nil) in
                    if let i = self.tableViewData[2].sectionData.firstIndex(where: {$0.friendName == friendName}){
                        index1 = i
                        print("index1",index1)
                    }
                    if let i = self.tableViewData[3].sectionData.firstIndex(where: {$0.friendName == friendName}){
                        index2 = i
                        print("index2",index2)
                    }
                    self.tableViewData[2].sectionData[index1].isMarked = !markStatus
                    self.tableViewData[3].sectionData[index2].isMarked = !markStatus
                    
                    self.tableViewData[2].sectionData.removeAll(where: {$0.friendName == friendName})
                    
                    if self.tableViewData[2].sectionData.count == 0 {
                        self.tableViewData.remove(at: 2)
                    }
                    self.myTable.reloadData()
                }
                markAction.backgroundColor = .blue
                markAction.image = UIImage(named: "filledstar" )
                
                return UISwipeActionsConfiguration(actions: [markAction])
            }
            else{
                markAction = UIContextualAction(style: .normal, title: "추가"){
                    (action, view, nil) in
                
                    self.tableViewData[indexPath.section].sectionData[indexPath.row - 1].isMarked = !markStatus
                    
                    if !self.markedExists() {
                        self.tableViewData.insert(self.markedFriends, at: 2)
                    }
                    self.tableViewData[2].sectionData.append(friendCell(friendName: friendName, isMarked: true))
                    
                    self.tableViewData[2].sectionData.sort{ $0.friendName < $1.friendName}
                    self.myTable.reloadData()
                }
                markAction.backgroundColor = .blue
                markAction.image = UIImage(named: "starmark" )
                
                return UISwipeActionsConfiguration(actions: [markAction])
            }
            
        }
        else {
            return .none
        }
    }
    
    
    //MARK: Trailing Swipe Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section >= 2, indexPath.row != 0 {
            let delete = deleteAction(at: indexPath)
            return UISwipeActionsConfiguration(actions: [delete])
        }
        else {
            return .none
        }
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "차단") { (action, view, nil) in
            let friendName = self.tableViewData[indexPath.section].sectionData[indexPath.row - 1 ].friendName
            if self.markedExists() {
                self.tableViewData[2].sectionData.removeAll(where: {$0.friendName == friendName})
                self.tableViewData[3].sectionData.removeAll(where: {$0.friendName == friendName})
                if self.tableViewData[2].sectionData.count == 0 {
                    self.tableViewData.remove(at: 2)
                }
            }
            else {
                self.tableViewData[2].sectionData.removeAll(where: {$0.friendName == friendName})
            }
            
            //UserDefaults.standard.set(self.tableViewData[2].sectionData, forKey: "SavedFriend")
            self.myTable.reloadData()
        }
        action.backgroundColor = .red
        return action
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 1, indexPath.row == 1 {
            print("selected!!")
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "NewFriendView") as! NewFriendView
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func markedExists() -> Bool {
        if tableViewData[2].title == "친구" {
            return false
        }
        return true
    }
    
}

//MARK: Delegate
extension FirstItem: AddFriendDelegate {
    func addFriend(friendName: String) {
        if tableViewData[2].title == "친구" {
            self.tableViewData[2].sectionData.append(friendCell(friendName: friendName, isMarked: false))
            self.tableViewData[2].sectionData.sort{ $0.friendName < $1.friendName}
        }
        else {
            self.tableViewData[3].sectionData.append(friendCell(friendName: friendName, isMarked: false))
            self.tableViewData[3].sectionData.sort{ $0.friendName < $1.friendName}
        }
        //UserDefaults.standard.set(tableViewData[2].sectionData, forKey: "SavedFriend")
        self.myTable.reloadData()
    }
}

