//
//  NewsTableViewController.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

/// The app's news list feed view. It will show a list will all the fetched news from NewsFeedViewModel
///
///
struct NewsFeedListView: View {

    @EnvironmentObject var userAuth: UserAuth

    @State private var showFavoritesOnly = false

    @StateObject var newsFeed = NewsFeedViewModel()

    var filteredNews: [NewsModel] {
        newsFeed.newsFeedItems.filter { newsFeed in
            let isFavorite = UserDefaults.standard.bool(forKey: "\(self.userAuth.email)_\(newsFeed.id!)")
            return (!showFavoritesOnly || isFavorite)
        }
    }

    var body: some View {
        List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }

            ForEach(filteredNews) { news in
                NewsFeedListItem(news: news).environmentObject(userAuth)
            }
        }.onAppear {
            newsFeed.fetchNewsFeed()
        }
    }
}

struct NewsTableView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedListView()
    }
}
