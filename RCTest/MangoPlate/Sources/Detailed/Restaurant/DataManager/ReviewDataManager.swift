//
//  ReviewDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/25.
//

import Alamofire

class ReviewDataManager {
    func getReview(id: Int, viewController: RestaurantViewController) {
        let url = "\(Constant.BASE_URL)/reviews/\(id)"
        let encodedurl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedurl!, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: ReviewResponse.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.didRetrieveReview(response.result!)
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
          
    }
}
