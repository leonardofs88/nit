//
//  NewsCarouselViewController.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import SwiftUI

struct NewsCarouselView: View {

    @StateObject var highlightedNews = NewsFeedViewModel()

    @State private var currentIndex: Int = 0

    private var numberOfNews: Int

    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    init(numberOfNews: Int) {
        self.numberOfNews = numberOfNews
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(highlightedNews.highlightNews) { item in
                    NewsCarouselItem(news: item, size: geometry.size)
                        .frame(width: geometry.size.width, height: 150)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
            .animation(.spring())
            .onReceive(self.timer) { _ in
                self.currentIndex = (self.currentIndex + 1) % numberOfNews
            }
        }.frame(height: 150)
        .onAppear {
            highlightedNews.fetchHighlights()
        }
    }
}

struct NewsCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        NewsCarouselView(numberOfNews: 3)
    }
}
