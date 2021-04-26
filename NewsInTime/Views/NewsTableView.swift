//
//  NewsTableViewController.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct NewsTableView: View {

    @State private var showHighlightsOnly = false

    @StateObject var newsFeed = NewsFeedViewModel()

    var highlightedNews: [NewsModel] {
        newsFeed.newsFeedItems.filter { newsFeed in
            (!showHighlightsOnly || newsFeed.highlight!)
        }
    }

    var body: some View {
        List {
            Toggle(isOn: $showHighlightsOnly) {
                Text("Favorites only")
            }

            ForEach(highlightedNews) { news in
                NewsTableCell(news: news)
            }
        }
    }
}

struct NewsTableView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTableView()
    }
}
