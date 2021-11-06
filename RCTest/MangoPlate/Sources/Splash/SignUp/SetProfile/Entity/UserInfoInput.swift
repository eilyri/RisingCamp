//
//  UserInfoInput.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/24.
//

struct UserInfoInput: Encodable {
    var email: String
    var password: String
    var phoneNumber: String
    var nickname: String
    var profileImage: String?
}
