//
//  NewsModel.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import Foundation

struct NewsModel: Hashable, Codable, Identifiable {
    var id: Int?
    var title: String?
    var description: String?
    var content: String?
    var author: String?
    var publishedAt: Date?
    var highlight: Bool?
    var url: String?
    var imageUrl: String?
}
