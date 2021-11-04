//
//  AddTextField.swift
//  week2
//
//  Created by 권하은 on 2021/07/06.
//

import Foundation
import UIKit

protocol AddContentDelegate {
    func addContent(content: Content)
}

class AddTextField : UIViewController {
    
    var delegate: AddContentDelegate?
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancleButton))
        
        view.backgroundColor = .white
        
        view.addSubview(textView)
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: view.frame.width-50).isActive = true
        textView.heightAnchor.constraint(equalToConstant: view.frame.height-300).isActive = true
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 10
        
        textView.becomeFirstResponder()
    }
    
    @objc func doneButton(){
        guard let myText = textView.text, textView.hasText else{
            print("TextViewError")
            return
        }
        
        let content = Content(mytext: myText, myname: "아일린")
        
        delegate?.addContent(content: content)
    }
    
    @objc func cancleButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }*/
    
}
