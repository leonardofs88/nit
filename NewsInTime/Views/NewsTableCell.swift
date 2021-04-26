//
//  NewsTableCellViewController.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct NewsTableCell: View {

    @State var isSet = false

    let news: NewsModel

    var formattedDate: String

    init(news: NewsModel) {
        self.news = news
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        self.formattedDate = formatter.string(from: news.publishedAt!)
        self.isSet = news.highlight!
    }

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            GeometryReader { geometry in
                AsyncImage(url: URL(string: news.imageUrl!)!, width: geometry.size.width, height: 100.0) {
                    Text("Loading image...")
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(news.title ?? "Title")
                    .font(.title3)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 100, alignment: .leading)
                    .lineLimit(2)
                Text(news.description ?? "Content")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).lineLimit(2)
            }.frame(maxWidth: .infinity)
            HStack {
                Text(self.formattedDate)
                FavoriteButton(isSet: $isSet)
            }
        }.frame(height: 250, alignment: .center)
    }
}

struct NewsTableCellView_Previews: PreviewProvider {
    static let news = NewsModel()
    static var previews: some View {
        NewsTableCell(news: news)
    }
}
