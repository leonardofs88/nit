//
//  NewsFeed.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import SwiftUI

/// The app's news feed view. It will show a carousel with highlighted news and a list with all other news
///
///
struct NewsFeed: View {

    @EnvironmentObject var userAuth: UserAuth

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 25, content: {
                NewsCarouselView(numberOfNews: 3)
                NewsFeedListView().environmentObject(userAuth)
            }).navigationTitle("NewsFeed")
        }
    }
}

struct NewsFeed_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeed()
    }
}
