//
//  ThirdItem.swift
//  week2
//
//  Created by 권하은 on 2021/07/15.
//

import Foundation
import UIKit

struct switchCell {
    var label = String()
    var switchOn = Bool()
}

class ThirdItem : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var testTable: UITableView!
    
    var cellList = [switchCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...100 {
            cellList.append(switchCell(label: "배고파", switchOn: false))
        }
        
        testTable.delegate = self
        testTable.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
        
        cell.cellLabel.text = cellList[indexPath.row].label
        cell.tableSwitch.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        cell.tableSwitch.isOn = cellList[indexPath.row].switchOn
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func handleSwitch(sender: UISwitch){
        let point = sender.convert(CGPoint.zero, to: testTable)
        guard let indexpath = testTable.indexPathForRow(at: point) else {return}
        if sender.isOn {
            cellList[indexpath.row].switchOn = true
        }
        else {
            cellList[indexpath.row].switchOn = false
        }
    }
    
    
    
}
