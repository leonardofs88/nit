//
//  AuthenticationViewModel.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 27/04/21.
//

import Foundation

/// A view model for authentication services
///
///
class AuthenticationViewModel: Service, ObservableObject {

    @Published var isSigned: Bool = false

    /// Authentication façade for Service's authentication method
    ///
    ///
    /// - Parameter name: `String?` name of the user,  optional if it's for sign in mode
    /// - Parameter email: `String` email of the user, obrigatory for all modes
    /// - Parameter password: `String` password of the user, obrigatory for all modes
    /// - Parameter for mode: `AuthenticationMode` the type of authentication
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
