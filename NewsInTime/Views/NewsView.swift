//
//  NewsView.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

/// The initial view of the app, it shows SignIn view by default and shows the NewsFeed when user is authenticated
///
///
struct NewsView: View {

    @StateObject var userAuth = UserAuth()

    var body: some View {
        if !userAuth.isLoggedin {
            SignInView().environmentObject(userAuth)
        } else {
            NewsFeed().environmentObject(userAuth)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
