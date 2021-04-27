//
//  NewsTableCellViewController.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

/// The app's news feed item view. It will render the news from the list of parent view NewFeedListView
///
///
struct NewsFeedListItem: View {

    @EnvironmentObject var userAuth: UserAuth

    @State var isSet = false

    let news: NewsModel

    var formattedDate: String

    init(news: NewsModel) {
        self.news = news
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        self.formattedDate = formatter.string(from: news.publishedAt!)
    }

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            GeometryReader { geometry in
                AsyncImageView(url: URL(string: news.imageUrl!)!, width: geometry.size.width, height: 100.0) {
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
            HStack(alignment: .center, spacing: 10) {
                Text("Published at: \(self.formattedDate)").font(.caption2)
                Spacer()
                Button(action: {
                },
                label: {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .onTapGesture {
                    actionSheet(news.url!)
                }
                .frame(width: 20, height: 20)
                Spacer()
                FavoriteButton(isSet: $isSet, newsId: news.id!)
                    .environmentObject(userAuth)
                    .onAppear {
                        self.isSet = UserDefaults
                            .standard
                            .bool(forKey: "\(self.userAuth.email)_\(self.news.id!)")
                    }
            }
        }.frame(height: 250, alignment: .center)
    }

    private func actionSheet(_ urlString: String) {
        guard let data = URL(string: urlString) else { return }
        let sheet = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(sheet, animated: true, completion: nil)
    }
}

struct NewsTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedListItem(news: newsFeed[0])
    }
}
