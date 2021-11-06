//
//  UserInfoResponse.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/19.
//

struct UserInfoResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
