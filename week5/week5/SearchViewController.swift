//
//  SearchViewController.swift
//  week5
//
//  Created by 권하은 on 2021/07/27.
//

import Foundation
import UIKit
import MaterialComponents.MaterialBottomSheet
import GoogleSignIn

struct ChargeInfo {
    var chargeTp: String! //충전기타입
    var cpId: String! //충전기ID
    var cpNm: String! //충전기명칭
    var cpStat: String! //충전기상태
    var cpTp: String! //충전방식
    var csId: String! //충전소ID
}

struct ParseInfo {
    var addr: String! //충전소주소
    var csId: String! //충전소ID
    var csNm: String! //충전소명칭
    var statUpdateDatetime: String! //충전기상태갱신시각
    var isMarked: Bool!
}

class SearchViewController: UIViewController, MDCBottomSheetControllerDelegate{
    
    @IBOutlet weak var myTable: UITableView!
    
    //MARK: 필터
    @IBAction func filterbutton(_ sender: Any) {
        let fvc = storyboard?.instantiateViewController(identifier: "FilterViewController") as! FilterViewController
        fvc.delegate = self
        present(fvc, animated: true, completion: nil)
    }
    @IBOutlet weak var filterButtonImg: UIButton!
    
    //MARK: 즐겨찾기
    var markStatus: Bool = false
    @IBOutlet weak var markButtonImg: UIButton!
    @IBAction func markButton(_ sender: Any) {
        markStatus = !markStatus
        
        if markStatus {
            markButtonImg.setImage(UIImage(named: "filledstar"), for: .normal)
            filterList = infoList.filter({$0.isMarked == true})
            myTable.reloadData()
        }
        else {
            markButtonImg.setImage(UIImage(named: "star1"), for: .normal)
            filterList = infoList
            myTable.reloadData()
        }
    }
    
    var elementValue: String!
    var tempInfoModel: ParseInfo!
    var tempChargeModel: ChargeInfo!
    var infoList = [ParseInfo]()
    var chargeList = [ChargeInfo]()
    var filterList = [ParseInfo]()
    
    var xmlParser: XMLParser!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let key = "AadnY0Bd%2FPPiTgNdqWqyijoaOiBdiJkjX3ywAqFZYszT39sS9nQr09HTYQMpMpWkHBHqljxJckolxIkJ2JrAPQ%3D%3D"
        let url = "http://openapi.kepco.co.kr/service/EvInfoServiceV2/getEvSearchList?serviceKey=\(key)&pageNo=1&numOfRows=2200"
        
        xmlParser = XMLParser(contentsOf: URL(string: url)!)
        xmlParser!.delegate = self
        xmlParser!.parse()
        filterList = infoList
        
        self.myTable.rowHeight = UITableView.automaticDimension
        myTable.delegate = self
        myTable.dataSource = self
        myTable.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTable.reloadData()
    }
}

//MARK: Table
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        cell.contentView.backgroundColor = #colorLiteral(red: 0.6542453766, green: 0.9075203538, blue: 0.9863128066, alpha: 1)
        var isCharge = [String]()
        
        for i in chargeList {
            if i.csId == filterList[indexPath.row].csId {
                isCharge.append(i.cpStat)
            }
        }
        
        if isCharge.contains("1") {
            cell.isAble.layer.borderColor = #colorLiteral(red: 0.05310823768, green: 0.691871345, blue: 0.4240782261, alpha: 1)
            cell.isAble.textColor = #colorLiteral(red: 0.05310823768, green: 0.691871345, blue: 0.4240782261, alpha: 1)
            cell.isAble.text = "충전가능"
        }
        else if isCharge.contains("2") {
            cell.isAble.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            cell.isAble.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            cell.isAble.text = "충전중"
        }
        else if isCharge.contains("3"){
            cell.isAble.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.isAble.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.isAble.text = "점검중"
        }
        else {
            cell.isAble.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.isAble.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.isAble.text = "미확인"
        }
        
        cell.statNameLabel.text = filterList[indexPath.row].csNm
        cell.statAddrLabel.text = filterList[indexPath.row].addr
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "BottomViewController") as! BottomViewController
        
        var tempList = [ChargeInfo]()
        for i in chargeList {
            if i.csId == filterList[indexPath.row].csId {
                tempList.append(i)
            }
        }
        
        vc.statAddr = filterList[indexPath.row].addr
        vc.updateTime = filterList[indexPath.row].statUpdateDatetime
        vc.passedList = tempList
        
        vc.myData.isStar = filterList[indexPath.row].isMarked
        vc.myData.statName = filterList[indexPath.row].csNm
        vc.delegate = self
        
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        
        self.present(bottomSheet, animated: true, completion: nil)
    }
}

//MARK: XMLParserDelegate
extension SearchViewController: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //currentElementName = elementName
        
        if elementName == "item" {
            tempInfoModel = ParseInfo()
            tempChargeModel = ChargeInfo()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue == nil {
            elementValue = string
        }
        else {
            elementValue = "\(elementValue!)\(string)"
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            tempInfoModel.isMarked = false
            var infobool: Bool = false
            
            for i in infoList {
                if i.csNm == tempInfoModel.csNm {
                    infobool = true
                }
            }
            if infobool == false {
                infoList.append(tempInfoModel)
            }
            
            chargeList.append(tempChargeModel)
        }
        else if elementName == "addr" {
            tempInfoModel.addr = elementValue
        }
        else if elementName == "chargeTp" {
            tempChargeModel.chargeTp = elementValue
        }
        else if elementName == "cpId" {
            tempChargeModel.cpId = elementValue
        }
        else if elementName == "cpNm" {
            tempChargeModel.cpNm = elementValue
        }
        else if elementName == "cpStat" {
            tempChargeModel.cpStat = elementValue
        }
        else if elementName == "cpTp" {
            tempChargeModel.cpTp = elementValue
        }
        else if elementName == "csId" {
            tempInfoModel.csId = elementValue
            tempChargeModel.csId = elementValue
        }
        else if elementName == "csNm" {
            tempInfoModel.csNm = elementValue
        }
        else if elementName == "statUpdateDatetime" {
            tempInfoModel.statUpdateDatetime = elementValue
        }
        elementValue = nil
    }
}

extension SearchViewController: SendDataDelegate {
    func sendData(pass: passData) {
        for i in 0...(infoList.count - 1) {
            if infoList[i].csNm == pass.statName {
                infoList[i].isMarked = pass.isStar
            }
        }
        for i in 0...(filterList.count - 1) {
            if filterList[i].csNm == pass.statName {
                filterList[i].isMarked = pass.isStar
            }
        }
        myTable.reloadData()
    }
}

extension SearchViewController: SendFilterDelegate {
    func sendFilter(filter: filterData) {
        if filter.addr != "전체" {
            filterList = infoList.filter({ $0.addr.contains(filter.addr) })
        }
        else {
            filterList = infoList
        }
        
        myTable.reloadData()
    }
}
