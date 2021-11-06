//
//  EatDealViewController.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/19.
//

import UIKit

class EatDealViewController: BaseViewController {
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var eatDealTableView: UITableView!
    
    var eatdealList = [EatDealResult]()
    
    private let myEatDealButton: MyEatDealCustomButton = {
        let button = MyEatDealCustomButton(frame: CGRect(x: 15, y: 7, width: 65, height: 32))
        button.backgroundColor = .white
        button.tintColor = .mainOrange
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        eatDealTableView.delegate = self
        eatDealTableView.dataSource = self
        eatDealTableView.register(UINib(nibName: "EatDealTableViewCell", bundle: nil), forCellReuseIdentifier: "EatDealTableViewCell")
        eatDealTableView.rowHeight = UITableView.automaticDimension
        eatDealTableView.estimatedRowHeight = 55
        
        buttonView.addSubview(myEatDealButton)
        let viewModel = MyEatDealButtonViewModel(title: "지역 선택")
        myEatDealButton.configure(with: viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
        EatDealDataManager().getEatDeal(viewController: self)
    }
}

extension EatDealViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eatdealList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EatDealTableViewCell", for: indexPath) as! EatDealTableViewCell
            cell.selectionStyle = .none
            
            if eatdealList.count != 0 {
                let url = URL(string: eatdealList[indexPath.row - 1].image ?? "")
                let data = try? Data(contentsOf: url!)
                cell.foodImageView.image = UIImage(data: data!)
                cell.noteLabel.text = eatdealList[indexPath.row - 1].simpleInfo
                cell.percentLabel.text = "\(eatdealList[indexPath.row - 1].discount!)%"
                cell.costPriceLabel.attributedText = "₩\(eatdealList[indexPath.row - 1].costPrice!)".strikeThrough()
                cell.salePriceLabel.text = "₩\(eatdealList[indexPath.row - 1].salePrice!)"
                cell.nameLabel.text = eatdealList[indexPath.row - 1].name
                cell.menuLabel.text = eatdealList[indexPath.row - 1].menu
            }
            
            
            return cell
        }
    }
}

//MARK: API Functions
extension EatDealViewController {
    func didRetrieveEatDeal(_ result: [EatDealResult]) {
        dismissIndicator()
        eatdealList = result
        print(eatdealList)
        eatDealTableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        dismissIndicator()
        presentAlert(message: message)
    }
}
