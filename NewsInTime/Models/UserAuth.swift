//
//  UserAuth.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import Foundation
import Combine

/// Model for user authentication object used in the app
///
///
class UserAuth: ObservableObject {

    @Published var isLoggedin = false {
        didSet {
            didChange.send(self)
        }
    }

    @Published var email = "" {
        didSet {
            didChange.send(self)
        }
    }

    let didChange = PassthroughSubject<UserAuth, Never>()

    let willChange = PassthroughSubject<UserAuth, Never>()

    /// When called, publishes the isLoggedin variable to it's observers
    ///
    ///
    func login() {
        self.isLoggedin = true
    }

}
