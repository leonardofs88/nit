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

    let willChange = PassthroughSubject<UserAuth, Never>()

    func login() {
        self.isLoggedin = true
    }

    func setName(name: String) {
        self.email = name
    }

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
}
