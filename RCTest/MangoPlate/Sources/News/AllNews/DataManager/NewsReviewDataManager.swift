//
//  NewsReviewDataManager.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/25.
//

import Alamofire

class NewsReviewDataManager {
    func getReview(evaluation: String, viewController: AllNewsViewController) {
        let url = "\(Constant.BASE_URL)/news/?evaluation=\(evaluation)"
        let encodedurl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedurl!, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: NewsReviewResponse.self) { response in
                switch response.result {
                case .success(let response):
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(response.result), forKey: "newsListKey")
                    viewController.dismissIndicator()
                    viewController.didRetrieveNewsReview(response.result!)
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
    }
}

