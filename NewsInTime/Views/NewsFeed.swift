//
//  NewsFeed.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import SwiftUI

struct NewsFeed: View {

    @EnvironmentObject var userAuth: UserAuth

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 25, content: {
                NewsCarouselView(numberOfNews: 3)
                NewsTableView().environmentObject(userAuth)
            }).navigationTitle("NewsFeed")
        }
    }
}

struct NewsFeed_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeed()
    }
}
