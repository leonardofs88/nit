//
//  NewsView.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct NewsView: View {

    @StateObject var userAuth = UserAuth()

    var body: some View {
        if !userAuth.isLoggedin {
            SignInView().environmentObject(userAuth)
        } else {
            NewsFeed()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
