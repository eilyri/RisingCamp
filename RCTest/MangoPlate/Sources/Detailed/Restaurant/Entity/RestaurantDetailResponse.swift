//
//  RestaurantDetailResponse.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/24.
//

struct RestaurantDetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [DetailResult]?
}

struct DetailResult: Decodable {
    var name: String?
    var roadNameAddress: String?
    var lotNumberAddress: String?
    var callNumber: String?
    var imageUrl: String?
    var views: Int?
    var reviews: Int?
    var starCount: Int?
    var rating: String?
    var businessHour: String?
    var holiday: String?
    var lastOrder: String?
    var priceInfo: String?
    var infoUpdate: String?
    var menu: String?
    var price: String?
    var menuUpdate: String?
}
