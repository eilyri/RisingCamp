//
//  EmailLoginDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/20.
//

import Alamofire

class EmailLoginDataManager {
    func emailLogin(_ parameters: EmailLoginInput, viewController: EmailLoginViewController) {
        AF.request("\(Constant.BASE_URL)/login", method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: EmailLoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.code == 1000 {
                        viewController.loginSucceed(response.result!)
                    }
                    else {
                        viewController.dismissIndicator()
                        viewController.presentAlert(message: response.message)
                    }
                case .failure(let error):
                    //viewController.dismissIndicator()
                    print(error.localizedDescription)
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
    }
}
