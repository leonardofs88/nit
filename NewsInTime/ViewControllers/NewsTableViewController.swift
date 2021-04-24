//
//  NewsTableViewController.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct NewsTableViewController: View {
    let newsFeed: [NewsModel]

    init(newsFeed: [NewsModel]) {
        self.newsFeed = newsFeed
    }

    var body: some View {
        List {
            ForEach(newsFeed) { news in
                NewsTableCellViewController(news: news)
            }
        }
    }
}

struct NewsTableViewController_Previews: PreviewProvider {
    static let newsFeed = [NewsModel(id: 1, title: "News 1"), NewsModel(id: 2, title: "News 2")]
    static var previews: some View {
        NewsTableViewController(newsFeed: newsFeed)
    }
}
