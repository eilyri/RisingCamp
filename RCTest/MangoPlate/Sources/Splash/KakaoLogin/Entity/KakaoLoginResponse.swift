//
//  KakaoLoginResponse.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/22.
//

struct KakaoLoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: KakaoLoginResult?
}

struct KakaoLoginResult: Decodable {
    var id: Int?
    var jwt: String?
}
