//
//  GetUserInfoResponse.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/26.
//

struct GetUserInfoResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: GetUserInfoResult?
}

struct GetUserInfoResult: Decodable {
    var nickname: String?
    var profileImage: String?
    var followers: Int?
    var followings: Int?
}
