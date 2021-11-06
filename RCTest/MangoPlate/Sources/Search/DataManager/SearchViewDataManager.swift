//
//  SearchViewDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/23.
//

import Alamofire

class SearchViewDataManager {
    func getRestaurant(area: String, viewController: SearchViewController) {
        let url = "\(Constant.BASE_URL)/restaurants/?area=\(area)"
        let encodedurl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedurl!, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: SearchViewResponse.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.didRetrieveRestaurants((response.result!))
                case .failure(let error):
                    print(error.localizedDescription, "searchView")
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
    }
}

