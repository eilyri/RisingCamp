//
//  LogoutDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/26.
//

import Alamofire

class LogoutDataManager {
    func logout(viewController: SettingsViewController) {
        //let HEADERS: HTTPHeaders = ["x-access-token": UserDefaults.standard.string(forKey: "jwtKey")!]
        AF.request("\(Constant.BASE_URL)/logout", method: .post, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: LogoutResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.code == 1000 {
                        viewController.didLogout()
                    }
                    print(response.message)
                case .failure(let error):
                    //viewController.dismissIndicator()
                    print(error.localizedDescription)
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
    }
}
