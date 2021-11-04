//
//  SecondItem.swift
//  week2
//
//  Created by 권하은 on 2021/07/06.
//

import Foundation
import UIKit

struct Content : Codable {
    var mytext : String
    var myname : String
}

class SecondItem : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var contents = [Content]()
    
    @IBOutlet weak var adImg: UIImageView!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contents.count == 0 {
            contents = [Content(mytext: "안녕!", myname: "친구1"), Content(mytext: "ㄹㄹㄴㅇㄹ", myname: "친구3"), Content(mytext: "ㅇㅁㄹㄴㄹ\n우와", myname: "친구4"), Content(mytext: "배고파", myname: "친구5"), Content(mytext: "야옹", myname: "친구5"), Content(mytext: "Hiii", myname: "아일린"), Content(mytext: "더워", myname: "친구7"), Content(mytext: "ㅁㄴㅇㄹㄹ", myname: "친구a")]
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTextButton))
        
        let textTableViewCellNib = UINib(nibName: "TextTableViewCell" , bundle: nil)
        
        self.table.register(textTableViewCellNib, forCellReuseIdentifier: "TextTableViewCell")
        
        self.table.rowHeight = UITableView.automaticDimension
        //self.table.estimatedRowHeight = 80
        
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.delegate = self
        table.dataSource = self
        table.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        if let myData = UserDefaults.standard.value(forKey: "SaveContents") as? Data {
            contents = try! PropertyListDecoder().decode(Array<Content>.self, from: myData)
        }
        
    }
    
    @objc func addTextButton(){
        
        let controller = AddTextField()
        controller.delegate = self
        
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as! TextTableViewCell
        //print("cell "+contents[indexPath.row].mytext)
        cell.myTextLabel.text = contents[indexPath.row].mytext
        cell.myNameLabel.text = contents[indexPath.row].myname
        cell.myProfileImg.image = UIImage(named: contents[indexPath.row].myname)
        
        /*let date = Date()
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM/dd a hh시 mm분"
        let str = myDateFormatter.string(from: date)
        cell.myDateLabel.text = str*/
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration (
            identifier: nil,
            previewProvider: nil) { _ in
            let copy = UIAction(title: "복사", image: UIImage(systemName: "doc.on.doc")) { _ in
                UIPasteboard.general.string = self.contents[indexPath.row].mytext
            }
            let delete = UIAction(
                title: "삭제",
                image: UIImage(systemName: "trash"),
                attributes: .destructive,
                handler: { _ in
                    if self.contents[indexPath.row].myname != "아일린" {
                        let alert = UIAlertController(title: "나에게서만 삭제", message: "삭제된 메시지는 내 게시판에서만 적용되며 상대방의 게시판에서는 삭제되지 않습니다", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {_ in
                            self.contents.remove(at: indexPath.row)
                            self.table.deleteRows(at: [indexPath], with: .none)
                            self.table.reloadData()
                        }))
                        self.present(alert, animated: true)
                    }
                    else{
                        self.contents.remove(at: indexPath.row)
                        self.table.deleteRows(at: [indexPath], with: .none)
                        self.table.reloadData()
                    }
                })
            return UIMenu(title: self.contents[indexPath.row].myname + ": " + self.contents[indexPath.row].mytext, children: [copy, delete])
        }
    }
    
    //MARK: change Ad
    func changeAd() {
        for x in (0...contents.count-1) {
            if contents[x].mytext.contains("강아지"){
                adImg.image = UIImage(named: "dogad")
            }
            else if contents[x].mytext.contains("애플워치"){
                adImg.image = UIImage(named: "applead")
            }
            else {
                adImg.image = UIImage(named: "bankad")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeAd()
        self.table.reloadData()
        self.scrollToBottom()
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.contents.count - 1, section: 0)
            self.table.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension SecondItem: AddContentDelegate {
    func addContent(content: Content) {
        self.dismiss(animated: true){
            self.contents.append(content)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.contents), forKey: "SaveContents")
            self.table.reloadData()
            self.scrollToBottom()
        }
    }
}
