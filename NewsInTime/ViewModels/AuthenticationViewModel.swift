//
//  AuthenticationViewModel.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 27/04/21.
//

import Foundation

class AuthenticationViewModel: Service, ObservableObject {

    @Published var isSigned: Bool = false

    func authenticate(name: String? = nil,
                      email: String,
                      password: String,
                      for mode: AuthenticationMode) {
        super.authentication(
            name: name,
            email: email,
            password: password,
            for: mode) { isSignedIn in
            self.isSigned = isSignedIn
        }
    }

}
