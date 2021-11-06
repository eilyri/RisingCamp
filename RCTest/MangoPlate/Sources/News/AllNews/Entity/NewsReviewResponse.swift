//
//  NewsReviewResponse.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/25.
//

struct NewsReviewResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [NewsReviewResult]?
}

struct NewsReviewResult: Codable {
    var id: Int?
    var nickname: String?
    var profileImage: String?
    var followerCount: Int?
    var reviewCount: Int?
    var holic: Int?
    var evaluation: String?
    var restaurantName: String?
    var area: String?
    var content: String?
    var reviewImage: String?
    var likeCount: Int?
    var commentCount: Int?
    var date: String?
}
