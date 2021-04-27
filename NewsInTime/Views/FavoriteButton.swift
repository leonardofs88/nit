//
//  FavoriteButton.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 26/04/21.
//

import SwiftUI

struct FavoriteButton: View {

    @EnvironmentObject var userAuth: UserAuth

    @Binding var isSet: Bool

    var newsId: Int

    var body: some View {
        Button(
            action: {
                isSet.toggle()
                UserDefaults.standard.setValue(isSet, forKey: "\(userAuth.email)_\(newsId)")
            },
            label: {
                Image(systemName: isSet ? "star.fill" : "star")
                    .foregroundColor(isSet ? Color.yellow : Color.gray)
            })
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true), newsId: 1)
    }
}
