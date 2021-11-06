//
//  EatDealResponse.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/25.
//

struct EatDealResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [EatDealResult]?
}

struct EatDealResult: Decodable {
    var id: Int?
    var name: String?
    var menu: String?
    var simpleInfo: String?
    var costPrice: String?
    var salePrice: String?
    var discount: String?
    var image: String?
}
