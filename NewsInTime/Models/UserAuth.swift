//
//  UserAuth.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 25/04/21.
//

import Foundation
import Combine

class UserAuth: ObservableObject {

    let didChange = PassthroughSubject<UserAuth, Never>()

    // required to conform to protocol 'ObservableObject'
    let willChange = PassthroughSubject<UserAuth, Never>()

    func login() {
        // login request... on success:
        self.isLoggedin = true
    }

    @Published var isLoggedin = false {
        didSet {
            didChange.send(self)
        }
    }
}
