//
//  User.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 24/04/21.
//

import Foundation

struct User: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var isLogged: Bool?

    init() {
        self.id = nil
        self.name = nil
        self.email = nil
        self.password = nil
        self.isLogged = nil
    }
}
