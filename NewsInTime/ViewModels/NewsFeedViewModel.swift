//
//  NewsFeedViewModel.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import Foundation
import Alamofire
import Combine

class NewsFeedViewModel: ObservableObject {

    @Published var newsFeedItems: [NewsModel] = []
    @Published var highlightNews: [NewsModel] = []

    init() {
        self.fetchNewsFeed()
        self.fetchHighlights()
    }

    private func fetchNewsFeed(currentPage: String = "", perPage: String = "", publishedAt: String = "") {
        Service
            .sharedInstance
            .get(for: "?current_page=\(currentPage)&per_page=\(perPage)&published_at=\(publishedAt)") { newsItems in
                let sorted = newsItems.sorted { $0.publishedAt!.compare($1.publishedAt!) == .orderedDescending  }
                self.newsFeedItems = sorted
            }
    }

    private func fetchHighlights() {
        Service.sharedInstance.get(for: "/highlights") { highlights in
            self.highlightNews = highlights
        }
    }
}
