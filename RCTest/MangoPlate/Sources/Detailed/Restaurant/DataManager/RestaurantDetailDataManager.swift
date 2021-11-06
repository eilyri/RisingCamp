//
//  RestaurantDetailDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/24.
//

import Alamofire

class RestaurantDetailDataManager {
    func getRestaurantDetail(id: Int, viewController: RestaurantViewController) {
        let url = "\(Constant.BASE_URL)/restaurants/\(id)"
        let encodedurl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedurl!, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: RestaurantDetailResponse.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.didRetrieveRestaurantDetail(response.result!)
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
          
    }
}
