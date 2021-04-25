//
//  NewsTableCellViewController.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct NewsTableCellViewController: View {
    let news: NewsModel

    init(news: NewsModel) {
        self.news = news
    }

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "applelogo").padding(10).frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 10) {
                Text(news.title ?? "Title")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 100, alignment: .leading)
                    .lineLimit(2)
                Text(news.description ?? "Content")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).lineLimit(2)
            }.frame(maxWidth: .infinity)
            Image(systemName: "star.fill").padding(10)
        }.frame(height: 250, alignment: .center)
    }
}

struct NewsTableCellViewController_Previews: PreviewProvider {
    static let news = NewsModel()
    static var previews: some View {
        NewsTableCellViewController(news: news)
    }
}
