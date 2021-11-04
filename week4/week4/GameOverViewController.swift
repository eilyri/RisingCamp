//
//  GameOverViewController.swift
//  week4
//
//  Created by 권하은 on 2021/07/23.
//

import Foundation
import UIKit

class GameOverViewController : UIViewController {
    @IBAction func gotoFirst(_ sender: Any) {
        view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    @IBAction func againButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var gameOverScoreLabel: UILabel!
    
    var score = 0
    var scoreArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.array(forKey: "SavedScore") != nil {
            scoreArray = UserDefaults.standard.array(forKey: "SavedScore") as! [Int]
        }
        
        scoreArray.append(score)
        gameOverScoreLabel.text = String(score)
        
        UserDefaults.standard.set(scoreArray, forKey: "SavedScore")
    }
}
