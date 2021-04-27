//
//  SignInView.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

/// A view for creating user and authentication
///
///
struct SignInView: View {

    @EnvironmentObject var userAuth: UserAuth

    @StateObject var authenticator = AuthenticationViewModel()

    @State var email = ""
    @State var password = ""
    @State var invalidEmail = false
    @State var invalidPassword = false
    @State var isSignedIn: Bool?

    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                Form {
                    TextField("E-Mail", text: $email)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                    Button(action: {
                        if email == "" {
                            self.invalidEmail = true
                        }
                        if password == "" {
                            self.invalidPassword = true
                        } else {
                            authenticator.authenticate(email: email, password: password, for: .signIn)
                        }
                    }, label: {
                        Text("Sign In")
                    }).onReceive(authenticator.$isSigned.dropFirst()) { isSigned in
                        self.userAuth.isLoggedin = isSigned
                        self.isSignedIn = isSigned
                        if isSigned {
                            self.userAuth.email = email
                        }
                    }

                    NavigationLink(
                        destination: SignUpView()
                            .environmentObject(userAuth),
                        label: {
                            Text("Don't have an account? Sign Up!")
                        })
                    if invalidEmail {
                        Text("Invalid e-mail.").foregroundColor(.red)
                    }
                    if invalidPassword {
                        Text("Invalid password.").foregroundColor(.red)
                    }
                    if let isSigned = self.isSignedIn, !isSigned {
                        Text("Wrong e-mail or passaword.").foregroundColor(.red)
                    }
                }
            }.navigationTitle("SignIn")
        }.environmentObject(userAuth)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
