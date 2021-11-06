//
//  EmailLoginViewControllerEntity.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/17.
//

struct EmailSignUpResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
