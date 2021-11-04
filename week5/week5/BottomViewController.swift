//
//  BottomViewController.swift
//  week5
//
//  Created by 권하은 on 2021/07/29.
//

import Foundation
import UIKit

struct passData {
    var isStar: Bool
    var statName: String
}

class BottomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return passedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        switch passedList[indexPath.row].cpTp {
        case "1":
            cell.typeLabel.text = "B타입(5핀)"
        case "2":
            cell.typeLabel.text = "C타입(5핀)"
        case "3":
            cell.typeLabel.text = "BC타입(5핀)"
        case "4":
            cell.typeLabel.text = "BC타입(7핀)"
        case "5":
            cell.typeLabel.text = "DC차데모"
        case "6":
            cell.typeLabel.text = "AC3상"
        case "7":
            cell.typeLabel.text = "DC콤보"
        case "8":
            cell.typeLabel.text = "DC차데모+DC콤보"
        case "9":
            cell.typeLabel.text = "DC차데모+AC3상"
        case "10":
            cell.typeLabel.text = "DC차데모+DC콤보+AC3상"
        default:
            print("switchdefault")
        }
        
        switch passedList[indexPath.row].cpStat {
        case "1":
            cell.cgstatLabel.text = "충전가능"
            cell.backgroundColor = #colorLiteral(red: 0.4371914864, green: 0.9771180749, blue: 0.7846042514, alpha: 1)
        case "2":
            cell.cgstatLabel.text = "충전중"
            cell.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case "3":
            cell.cgstatLabel.text = "고장/점검"
            cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case "4", "5":
            cell.cgstatLabel.text = "통신장애"
            cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        default:
            print("switchdefault")
        }
        
        return cell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bIsAble: UILabel!
    @IBOutlet weak var bStatName: UILabel!
    @IBOutlet weak var bStatAddr: UILabel!
    @IBOutlet weak var fastSlowCount: UILabel!
    @IBOutlet weak var udtTime: UILabel!
    
    @IBOutlet weak var bStarButton: UIButton!
    @IBAction func bStarButton(_ sender: Any) {
        myData.isStar = !myData.isStar
        if myData.isStar {
            bStarButton.setImage(UIImage(named: "filledstar"), for: .normal)
        }
        else{
            bStarButton.setImage(UIImage(named: "star1"), for: .normal)
        }
        print(myData.statName)
        delegate?.sendData(pass: myData)
    }
    
    var delegate: SendDataDelegate?
    var myData = passData(isStar: false, statName: "")
    
    var statAddr: String = ""
    var passedList = [ChargeInfo]()
    var fastCg: Int = 0
    var slowCg: Int = 0
    var updateTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if myData.isStar {
            bStarButton.setImage(UIImage(named: "filledstar"), for: .normal)
        }
        else{
            bStarButton.setImage(UIImage(named: "star1"), for: .normal)
        }
        
        var isCharge = [String]()
        for i in passedList {
            isCharge.append(i.cpStat)
            if i.chargeTp == "1"{
                slowCg += 1
            }
            else if i.chargeTp == "2"{
                fastCg += 1
            }
        }
        
        if fastCg == 0 {
            fastSlowCount.text = "완속 " + String(slowCg)
        }
        else if slowCg == 0 {
            fastSlowCount.text = "급속 " + String(fastCg)
        }
        else {
            fastSlowCount.text = "급속 " + String(fastCg) + " | 완속 " + String(slowCg)
        }
        
        if isCharge.contains("1") {
            bIsAble.text = "충전가능"
            bIsAble.textColor = #colorLiteral(red: 0.02855354175, green: 0.8164404035, blue: 0.500302434, alpha: 1)
            bIsAble.layer.borderColor = #colorLiteral(red: 0.02855354175, green: 0.8164404035, blue: 0.500302434, alpha: 1)
        }
        else if isCharge.contains("2") {
            bIsAble.text = "충전중"
            bIsAble.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            bIsAble.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
        else if isCharge.contains("3"){
            bIsAble.text = "점검중"
            bIsAble.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            bIsAble.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        else {
            bIsAble.text = "미확인"
            bIsAble.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            bIsAble.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        bStatName.text = myData.statName
    
        bStatAddr.text = statAddr
        udtTime.text = "업데이트: " + updateTime
    }
}

extension BottomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        let size = CGSize(width: width, height: 100)
        return size
    }
}

protocol SendDataDelegate {
    func sendData(pass: passData)
}
