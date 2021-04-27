//
//  NewsModel.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import Foundation
import SwiftyJSON

/// Codable model for the news that will be instantiated in the app
///
///
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

/// Extension for JSON encoding to NewsModel
///
///
extension NewsModel {
    init(with json: JSON) {
        self.id = json["id"].int ?? 0
        self.title = json["title"].string!
        self.description = json["description"].string!
        self.content = json["content"].string!
        self.author = json["author"].string!
        self.highlight = json["highlight"].bool!
        self.url = json["url"].string!
        self.imageUrl = json["image_url"].string!

        let date = json["published_at"].string!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.formatterBehavior = .default
        if let dateString = dateFormatter.date(from: date) {
            self.publishedAt = dateString
        }
    }
}

/// Codable model for news to be shown in the Feed with pagination
///
///
struct NewsFeedModel: Codable {
    var newsFeed: [NewsModel]
    var pagination: Pagination
}

/// Extension for JSON encoding to  NewsFeedModel
///
///
extension NewsFeedModel {
    init(with json: JSON) {
        self.pagination = Pagination(with: json["pagination"])
        self.newsFeed = []
        let newsFromJson = json["data"].array!
        newsFromJson.forEach { (feedJson) in
            self.newsFeed.append(NewsModel(with: feedJson))
        }
    }
}

/// Codable model for pagination on NewsFeedModel
///
///
struct Pagination: Codable {
    var currentPage: Int
    var perPage: Int
    var totalPages: Int
    var totalItems: Int
}

/// Extension for JSON encoding to Pagination
///
///
extension Pagination {
    init(with json: JSON) {
        self.currentPage = json["current_page"].int ?? 0
        self.perPage = json["per_page"].int ?? 0
        self.totalPages = json["total_pages"].int ?? 0
        self.totalItems = json["total_items"].int ?? 0
    }
}
