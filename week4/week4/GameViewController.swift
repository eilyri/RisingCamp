//
//  GameViewController.swift
//  week4
//
//  Created by 권하은 on 2021/07/18.
//

import Foundation
import UIKit

class GameViewController : UIViewController {
    
    @IBAction func goToRoot(_ sender: Any) {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: hearts
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    @IBOutlet weak var heart4: UIImageView!
    @IBOutlet weak var heart5: UIImageView!
    
    @IBOutlet var hearts: [UIImageView]!
    
    func heartCount(heartNum: Int) {
        if heartNum == 4 {
            heart5.tintColor = .gray
        }
        else if heartNum == 3 {
            heart4.tintColor = .gray
        }
        else if heartNum == 2 {
            heart3.tintColor = .gray
        }
        else if heartNum == 1 {
            heart2.tintColor = .gray
        }
        else if heartNum == 0 {
            heart1.tintColor = .gray
            let vc = self.storyboard?.instantiateViewController(identifier: "GameOverViewController") as! GameOverViewController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.score = score
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: customerButton
    private let myCustomerButton1: MyCustomerButton = {
        let button = MyCustomerButton(frame: CGRect(x: 2, y: 175, width: 136, height: 240))
        button.addTarget(self, action: #selector(customerActivity), for: .touchUpInside)
        return button
    }()
    private let myCustomerButton2: MyCustomerButton = {
        let button = MyCustomerButton(frame: CGRect(x: 139, y: 175, width: 136, height: 240))
        button.addTarget(self, action: #selector(customerActivity), for: .touchUpInside)
        return button
    }()
    private let myCustomerButton3: MyCustomerButton = {
        let button = MyCustomerButton(frame: CGRect(x: 276, y: 175, width: 136, height: 240))
        button.addTarget(self, action: #selector(customerActivity), for: .touchUpInside)
        return button
    }()
    
    var succeed = [Int]()
    //MARK: customerActivity
    @objc func customerActivity(sender: MyCustomerButton) {
        let activityType: ActivityType = selectedActivityType()
        
        if activityType == .hand {
            let score1 = Int(sender.getText())
            if count >= score1! {
                count = count - score1!
                countLabel.text = String(count)
                score += (score1! * 30)
                scoreLabel.text = String(score)
                if sender == myCustomerButton1 {
                    succeed.append(1)
                }
                else if sender == myCustomerButton2 {
                    succeed.append(2)
                }
                else if sender == myCustomerButton3 {
                    succeed.append(3)
                }
                sender.removeFromSuperview()
            }
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
        
    @IBOutlet var activityTypeButtons: [UIButton]!
    
    @IBAction func activityTypeSelected(_ sender: UIButton) {
        activityTypeButtons.forEach({ $0.layer.borderWidth = 0 })
        
        sender.layer.borderWidth = 4
        sender.layer.cornerRadius = 1.5
        sender.layer.borderColor = UIColor.systemPink.cgColor
    }
    
    func selectedActivityType() -> ActivityType {
        for (index, button) in activityTypeButtons.enumerated() {
            if button.layer.borderWidth == 4 {
                return ActivityType(rawValue: index) ?? .paste
            }
        }
        return .milk
    }
    
    var cookState = ["uncooked", "cooked", "burn"]
        
    //MARK: moldSelected
    @IBAction func moldSelected(_ sender: UIButton) {
        let activityType: ActivityType = selectedActivityType()
        
        if activityType == .paste {
            if sender.image(for: .normal) == UIImage(named: "") {
                sender.setImage(UIImage(named: "paste"), for: .normal)
                
                DispatchQueue.global(qos: .userInteractive).async {
                    for i in 1...100 {
                        DispatchQueue.main.sync {
                            if sender.image(for: .normal) != UIImage(named: "paste") {
                                return
                            }
                            if i == 100 {
                                sender.setImage(UIImage(named: "burn"), for: .normal)
                            }
                        }
                        usleep(150000)
                    }
                }
            }
        }
        else if activityType == .milk {
            if sender.image(for: .normal) == UIImage(named: "paste") {
                sender.setImage(UIImage(named: "milk"), for: .normal)
                DispatchQueue.global(qos: .userInteractive).async {
                    for i in 1...100 {
                        DispatchQueue.main.sync {
                            if sender.image(for: .normal) != UIImage(named: "milk") {
                                return
                            }
                            else if i == 100 {
                                sender.setImage(UIImage(named: "burn"), for: .normal)
                            }
                        }
                        usleep(130000)
                    }
                }
            }
        }
        else if activityType == .egg {
            if sender.image(for: .normal) == UIImage(named: "milk") {
                sender.setImage(UIImage(named: "egg"), for: .normal)
                DispatchQueue.global(qos: .userInteractive).async {
                    for i in 1...100 {
                        DispatchQueue.main.sync {
                            if sender.image(for: .normal) != UIImage(named: "egg") {
                                return
                            }
                            else if i == 100 {
                                sender.setImage(UIImage(named: "burn"), for: .normal)
                            }
                        }
                        usleep(110000)
                    }
                }
            }
        }
        else if activityType == .pick {
            if sender.image(for: .normal) == UIImage(named: "cooked") {
                sender.setImage(UIImage(named: ""), for: .normal)
                count += 1
                countLabel.text = String(count)
            }
            else if sender.image(for: .normal) == UIImage(named: "egg") {
                sender.setImage(UIImage(named: "uncooked"), for: .normal)
                DispatchQueue.global(qos: .userInteractive).async {
                    for i in self.cookState {
                        DispatchQueue.main.sync {
                            if sender.image(for: .normal) == UIImage(named: "") {
                                return
                            }
                            else{
                                sender.setImage(UIImage(named: i), for: .normal)
                            }
                        }
                        usleep(3500000)
                    }
                }
            }
            else if sender.image(for: .normal) == UIImage(named: "burn") {
                sender.setImage(UIImage(named: ""), for: .normal)
            }
        }
    }
    
    var score = 0
    var count = 0
    
    var num = 0
    
    var customers = ["customer1", "customer2", "customer3", "customer4"]
    var isEmpty = [Int]()
    var randomNumber = 0
    
    var heart = 5
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        num = 0
        isEmpty = [ 1, 2, 3 ]
        hearts.forEach({ $0.tintColor = .yellow })
        succeed = []
        
        DispatchQueue.global(qos: .userInteractive).async {
            while(true) {
                DispatchQueue.main.sync {
                    self.randomNumber = self.isEmpty.randomElement() ?? 0
                    if self.randomNumber == 1 {
                        self.customer1(customer: self.customers[self.num % 4])
                        self.isEmpty.removeAll(where: { $0 == 1 })
                    }
                    else if self.randomNumber == 2 {
                        self.customer2(customer: self.customers[self.num % 4])
                        self.isEmpty.removeAll(where: { $0 == 2 })
                    }
                    else if self.randomNumber == 3 {
                        self.customer3(customer: self.customers[self.num % 4])
                        self.isEmpty.removeAll(where: { $0 == 3 })
                    }
                    self.num+=1
                }
                if self.randomNumber != 0 {
                    usleep(7000000)
                }
            }
        }
    }
    
    //MARK: func Customers
    func customer1(customer: String) {
        self.succeed.removeAll(where: { $0 == 1 })
        let num: Int = Int.random(in: 1...5)
        view.addSubview(myCustomerButton1)
        myCustomerButton1.configure(with: MyCustomerButtonViewModel(myCustomerText: String(num), myProgressWidth: 120))
        
        myCustomerButton1.setImage(UIImage(named: customer), for: .normal)
        DispatchQueue.global(qos: .userInteractive).async {
            for i in (0...30).reversed(){
                
                DispatchQueue.main.sync {
                    if !self.succeed.contains(1) {
                        if i == 2 {
                            self.myCustomerButton1.setImage(UIImage(named: "angry"+customer), for: .normal)
                        }
                        if i == 0 {
                            self.myCustomerButton1.removeFromSuperview()
                            self.heart -= 1
                            self.heartCount(heartNum: self.heart)
                            print(self.heart)
                            self.isEmpty.append(1)
                        }
                        self.myCustomerButton1.configure(with: MyCustomerButtonViewModel(myCustomerText: String(num), myProgressWidth: i * 4))
                    }
                }
                
                if self.succeed.contains(1) {
                    self.isEmpty.append(1)
                    //self.myCustomerButton1.removeFromSuperview()
                    break
                }
                
                usleep(1000000)
                
            }
            
        }
    }
    
    func customer2(customer: String) {
        self.succeed.removeAll(where: { $0 == 2 })
        let num: Int = Int.random(in: 1...5)
        view.addSubview(myCustomerButton2)
        myCustomerButton2.configure(with: MyCustomerButtonViewModel(myCustomerText: String(num), myProgressWidth: 120))
        
        myCustomerButton2.setImage(UIImage(named: customer), for: .normal)
        DispatchQueue.global(qos: .userInteractive).async {
            for i in (0...30).reversed() {
                DispatchQueue.main.sync {
                    if !self.succeed.contains(2) {
                        if i == 2 {
                            self.myCustomerButton2.setImage(UIImage(named: "angry"+customer), for: .normal)
                        }
                        
                        if (i == 0) {
                            self.myCustomerButton2.removeFromSuperview()
                            self.heart -= 1
                            self.heartCount(heartNum: self.heart)
                            print(self.heart)
                            self.isEmpty.append(2)
                        }
                        
                        self.myCustomerButton2.configure(with: MyCustomerButtonViewModel(myCustomerText: String(num), myProgressWidth: i * 4))
                    }
                }
                
                if self.succeed.contains(2) {
                    self.isEmpty.append(2)
                    //self.myCustomerButton2.removeFromSuperview()
                    break
                }
                usleep(1000000)
            }
        }
    }
    
    func customer3(customer: String) {
        self.succeed.removeAll(where: { $0 == 3 })
        let num: Int = Int.random(in: 1...5)
        view.addSubview(myCustomerButton3)
        myCustomerButton3.configure(with: MyCustomerButtonViewModel(myCustomerText: String(num), myProgressWidth: 120))
        
        myCustomerButton3.setImage(UIImage(named: customer), for: .normal)
        DispatchQueue.global(qos: .userInteractive).async {
            for i in (0...30).reversed(){
                DispatchQueue.main.sync {
                    if !self.succeed.contains(3) {
                        if i == 2 {
                            self.myCustomerButton3.setImage(UIImage(named: "angry"+customer), for: .normal)
                        }
                        if (i == 0) {
                            self.myCustomerButton3.removeFromSuperview()
                            self.heart -= 1
                            self.heartCount(heartNum: self.heart)
                            print(self.heart)
                            self.isEmpty.append(3)
                        }
                        self.myCustomerButton3.configure(with: MyCustomerButtonViewModel(myCustomerText: String(num), myProgressWidth: i * 4))
                    }
                }
                
                if self.succeed.contains(3) {
                    self.isEmpty.append(3)
                    //self.myCustomerButton3.removeFromSuperview()
                    break
                }
                usleep(1000000)
            }
        }
    }
}


