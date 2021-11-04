//
//  FilterViewController.swift
//  week5
//
//  Created by 권하은 on 2021/07/31.
//

import Foundation
import UIKit

struct filterData {
    var addr: String
    var fastcg: String
}

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sidoList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sidoList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if sidoList[row] == "전체" {
            sidoOutlet.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        sidoOutlet.setTitle(sidoList[row], for: .normal)
        sidoOutlet.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        myfilter.addr = sidoList[row]
    }
    
    @IBAction func sidoButton(_ sender: Any) {
        self.view.addSubview(doPicker)
        doPicker.backgroundColor = .lightGray
        doToolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 350, width: UIScreen.main.bounds.size.width, height: 50))
        doToolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(doToolBar)
    }
    
    @objc func onDoneButtonTapped() {
        doPicker.removeFromSuperview()
        doToolBar.removeFromSuperview()
    }
    
    @IBOutlet weak var sidoOutlet: UIButton!
    
    var doToolBar = UIToolbar()
    var doPicker: UIPickerView!
    var sidoList = ["전체","서울", "경기도", "인천", "강원도", "경상남도", "경상북도", "광주", "대구", "대전", "부산", "세종", "울산", "전라남도", "전라북도", "제주도", "충청남도", "충청북도"]
    
    var myfilter = filterData(addr: "", fastcg: "")
    var delegate: SendFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doPicker = UIPickerView()
        doPicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width  , height: 200)
        
        doPicker.delegate = self
        doPicker.dataSource = self
        
    }
    
    @IBAction func selectButton(_ sender: Any) {
        
        delegate?.sendFilter(filter: myfilter)
        self.dismiss(animated: true, completion: nil)
    }
    
}

protocol SendFilterDelegate {
    func sendFilter(filter : filterData)
}
