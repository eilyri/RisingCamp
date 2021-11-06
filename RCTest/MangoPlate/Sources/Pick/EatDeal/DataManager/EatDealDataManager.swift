//
//  EatDealDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/25.
//

import Alamofire

class EatDealDataManager {
    func getEatDeal(viewController: EatDealViewController) {
        let url = "\(Constant.BASE_URL)/eat-deal"
        let encodedurl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedurl!, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: EatDealResponse.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.didRetrieveEatDeal(response.result!)
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
          
    }
}
