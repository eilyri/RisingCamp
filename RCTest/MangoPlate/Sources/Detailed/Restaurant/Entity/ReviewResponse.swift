//
//  ReviewResponse.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/25.
//

struct ReviewResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ReviewResult]?
}

struct ReviewResult: Decodable {
    var nickname: String?
    var profileImage: String?
    var followerCount: Int?
    var reviewCount: Int?
    var holic: Int?
    var evaluation: String?
    var content: String?
    var reviewImage: String?
    var likeCount: Int?
    var commentCount: Int?
    var date: String?
}
