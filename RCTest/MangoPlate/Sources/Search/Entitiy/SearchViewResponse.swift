//
//  SearchViewResponse.swift
//  EduTemplate
//
//  Created by 권하은 on 2021/08/23.
//

struct SearchViewResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SearchResult]?
}

struct SearchResult: Decodable {
    var number: Int
    var id: Int
    var name: String
    var area: String
    var distance: String
    var imageUrl: String
    var views: Int
    var reviews: Int
    var rating: String?
}
