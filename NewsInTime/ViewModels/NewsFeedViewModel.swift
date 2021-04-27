//
//  NewsFeedViewModel.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import Foundation
import Alamofire
import Combine

/// A view model to fetch highlighted news and news from the feed
///
///
class NewsFeedViewModel: Service, ObservableObject {

    @Published var newsFeedItems: [NewsModel] = []
    @Published var highlightNews: [NewsModel] = []

    /// A façade for Service's get method
    ///
    ///
    /// - Parameter currentPage: `String` the current page for pagination
    /// - Parameter perPage: `String` page filter for pagination
    /// - Parameter publishedAt: `String` published date filter for pagination
    func fetchNewsFeed(currentPage: String = "", perPage: String = "", publishedAt: String = "") {
        self.get(for: "?current_page=\(currentPage)&per_page=\(perPage)&published_at=\(publishedAt)") { newsItems in
                let sorted = newsItems.sorted { $0.publishedAt!.compare($1.publishedAt!) == .orderedDescending  }
                self.newsFeedItems = sorted
            }
    }

    /// A façade for Service's fetchHighlight method
    ///
    ///
    func fetchHighlights() {
        self.get(for: "/highlights") { highlights in
            self.highlightNews = highlights
        }
    }
}
