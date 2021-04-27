//
//  ImageLoader.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import SwiftUI
import Combine
import Foundation
import AlamofireImage

/// The service used for render images from given URL
///
///
class AsyncImageViewModel: Service, ObservableObject {

    @Published var image: UIImage?

    private let url: URL

    init(url: URL) {
        self.url = url
    }

    /// Loads the image from the given URL
    ///
    ///
    func load() {
        self.manager.request(self.url).responseImage { (response) in
            switch response.result {
            case .failure(let error):
                print("Error while fetching image \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.image = Image(imageLiteralResourceName: "Logo")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }

}
