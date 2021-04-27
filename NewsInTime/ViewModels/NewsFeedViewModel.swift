//
//  NewsFeedViewModel.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import Foundation
import Alamofire
import Combine

class NewsFeedViewModel: Service, ObservableObject {

    @Published var newsFeedItems: [NewsModel] = []
    @Published var highlightNews: [NewsModel] = []

    func fetchNewsFeed(currentPage: String = "", perPage: String = "", publishedAt: String = "") {
        self.get(for: "?current_page=\(currentPage)&per_page=\(perPage)&published_at=\(publishedAt)") { newsItems in
                let sorted = newsItems.sorted { $0.publishedAt!.compare($1.publishedAt!) == .orderedDescending  }
                self.newsFeedItems = sorted
            }
    }

    func fetchHighlights() {
        self.get(for: "/highlights") { highlights in
            self.highlightNews = highlights
        }
    }
}
