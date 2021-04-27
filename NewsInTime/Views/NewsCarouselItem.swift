//
//  NewsCarouselItemViewController.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import SwiftUI

/// The app's news carousel item view. It will render the news from the list of parent view NewsCaroulselListView
///
///
struct NewsCarouselItem: View {

    var news: NewsModel
    var size: CGSize

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            AsyncImageView(url: URL(string: news.imageUrl!)!, width: self.size.width, height: 150.0) {
                Text("Loading image...")
            }

            Text(news.title ?? "")
                .font(.headline)
                .lineLimit(2)
                .background(Color.gray.opacity(0.9))
                .foregroundColor(.white)
                .alignmentGuide(.bottom, computeValue: { dimension in
                    dimension[.bottom]
                })
        }
    }
}

struct NewsCarouselItem_Previews: PreviewProvider {
    static var previews: some View {
        NewsCarouselItem(news: newsFeed[0], size: CGSize(width: 100.0, height: 100.0))
    }
}
