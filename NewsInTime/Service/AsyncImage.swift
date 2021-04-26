//
//  AsyncImage.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import SwiftUI
import Combine
import Foundation

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder

    var width: CGFloat?
    var height: CGFloat?

    init(url: URL, width: CGFloat? = nil, height: CGFloat? = nil, @ViewBuilder placeholder: () -> Placeholder) {
        self.width = width
        self.height = height
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .frame(width: self.width, height: self.height)
                    .clipped()
            } else {
                placeholder
            }
        }
    }
}
