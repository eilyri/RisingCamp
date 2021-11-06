//
//  GetUserInfoDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/26.
//

import Alamofire

class GetUserInfoDataManager {
    func getUserInfo(userId: Int, viewController: MyInfoViewController) {
        let url = "\(Constant.BASE_URL)/users/\(userId)"
        let encodedurl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedurl!, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: GetUserInfoResponse.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.didRetrieveUserInfo(response.result!)
                case .failure(let error):
                    print(error.localizedDescription, "searchView")
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
    }
}
