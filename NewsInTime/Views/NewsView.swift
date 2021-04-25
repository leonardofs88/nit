//
//  NewsView.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        NavigationView {
            VStack {
                NewsTableViewController(newsFeed: newsFeed)
            }.navigationTitle("NewsFeed")
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
