//
//  ViewController.swift
//  week4
//
//  Created by 권하은 on 2021/07/18.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func startButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func rankingButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "RankingViewController") as! RankingViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

