//
//  PlusViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/16.
//

import UIKit

class PlusViewController: BaseViewController {
    
    private let myShoweatdealButton: PlusCustomButton = {
        let button = PlusCustomButton(frame: CGRect(x: 40, y: 520, width: 65, height: 32))
        return button
    }()
    private let myDidgoButton: PlusCustomButton = {
        let button = PlusCustomButton(frame: CGRect(x: 40, y: 590, width: 65, height: 32))
        return button
    }()
    private let myWritereviewButton: PlusCustomButton = {
        let button = PlusCustomButton(frame: CGRect(x: 40, y: 660, width: 65, height: 32))
        return button
    }()
    private let myRegisterresButton: PlusCustomButton = {
        let button = PlusCustomButton(frame: CGRect(x: 40, y: 730, width: 65, height: 32))
        return button
    }()
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainOrange
        // Do any additional setup after loading the view.
        setButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setButtons() {
        view.addSubview(myShoweatdealButton)
        let viewModel = PlusCustomButtonViewModel(title: "EAT딜 보러가기", imgname: "showeatdeal")
        myShoweatdealButton.configure(with: viewModel)
        myShoweatdealButton.addTarget(self, action: #selector(showEatDeal), for: .touchUpInside)
        
        view.addSubview(myDidgoButton)
        let viewMode2 = PlusCustomButtonViewModel(title: "가봤어요", imgname: "didgo")
        myDidgoButton.configure(with: viewMode2)
        
        view.addSubview(myWritereviewButton)
        let viewModel3 = PlusCustomButtonViewModel(title: "리뷰 쓰기", imgname: "writereview")
        myWritereviewButton.configure(with: viewModel3)
        
        view.addSubview(myRegisterresButton)
        let viewModel4 = PlusCustomButtonViewModel(title: "식당 등록하기", imgname: "registerres")
        myRegisterresButton.configure(with: viewModel4)
    }
    
    @objc func showEatDeal() {
        self.dismiss(animated: false, completion: nil)
        if let tabBarController = self.presentingViewController as? BaseTabBarController {
            tabBarController.selectedIndex = 1
        }
    }

}
