//
//  Constant.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import Alamofire

struct Constant {
    static let BASE_URL = "https://prod.sq-mangoplate.shop/app"
    
    static var HEADERS: HTTPHeaders = ["x-access-token": JwtToken.token]
}
