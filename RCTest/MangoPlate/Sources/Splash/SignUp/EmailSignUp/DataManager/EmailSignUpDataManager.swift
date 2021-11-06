//
//  EmailLoginDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/17.
//

import Alamofire

class EmailSignUpDataManager {
    func usersemails(email: String, viewController: EmailSignUpViewController) {
        AF.request("\(Constant.BASE_URL)/users/emails/?email=\(email)", method: .get, parameters: nil)
            .validate()
            .responseDecodable(of: EmailSignUpResponse.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.emailCertify(result: response.isSuccess)
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.emailCertify(result: false)
                }
            }
    }
}
