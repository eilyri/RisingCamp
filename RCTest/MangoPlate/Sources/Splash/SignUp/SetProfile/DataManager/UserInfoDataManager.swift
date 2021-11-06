//
//  UserInfoDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/19.
//

import Alamofire

class UserInfoDataManager {
    func emailSignUp(_ parameters: UserInfoInput, viewController: SetProfileViewController) {
        AF.request("\(Constant.BASE_URL)/users", method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: UserInfoResponse.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.dismissIndicator()
                    viewController.presentAlert(message: response.message)
                    print(response.message)
                case .failure(let error):
                    viewController.dismissIndicator()
                    print(error.localizedDescription)
                }
            }
    }
}
