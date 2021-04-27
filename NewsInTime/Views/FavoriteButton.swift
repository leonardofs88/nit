//
//  FavoriteButton.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 26/04/21.
//

import SwiftUI

/// A favorite button component for the NewsFeedListItemView
///
///
struct FavoriteButton: View {

    @EnvironmentObject var userAuth: UserAuth

    @Binding var isSet: Bool

    var newsId: Int

    var body: some View {
        Button(
            action: {
            },
            label: {
                Image(systemName: isSet ? "star.fill" : "star")
                    .foregroundColor(isSet ? Color.yellow : Color.gray)
            })
            .onTapGesture {
                isSet.toggle()
                UserDefaults.standard.setValue(isSet, forKey: "\(userAuth.email)_\(newsId)")
            }
            .frame(width: 25, height: 25, alignment: .center)
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true), newsId: 1)
    }
}
