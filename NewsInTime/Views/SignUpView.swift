//
//  SignUpView.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI
/// A view for user initial authentication
///
///
struct SignUpView: View {

    @EnvironmentObject var userAuth: UserAuth

    @StateObject var authenticator = AuthenticationViewModel()

    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var invalidEmail = false
    @State var invalidPassword = false
    @State var invalidName = false
    @State var isSignedUp: Bool?

    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            Form {
                TextField("Name", text: $name)
                TextField("E-Mail", text: $email)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
                Button(action: {
                    if email == "" {
                        self.invalidEmail = true
                    } else
                    if password == "" {
                        self.invalidPassword = true
                    } else
                    if name == "" {
                        self.invalidName = true
                    } else {
                        authenticator.authenticate(
                            name: name,
                            email: email,
                            password: password,
                            for: .signUp)
                    }
                }, label: {
                    Text("Sign Up")
                }).onReceive(authenticator.$isSigned.dropFirst()) { isSigned in
                    self.userAuth.isLoggedin = isSigned
                    self.isSignedUp = isSigned
                    if isSigned {
                        self.userAuth.email = email
                    }
                }

                if invalidEmail {
                    Text("Invalid e-mail.").foregroundColor(.red)
                }
                if invalidPassword {
                    Text("Invalid password.").foregroundColor(.red)
                }
                if invalidName {
                    Text("Invalid name.").foregroundColor(.red)
                }
                if let isSigned = self.isSignedUp, !isSigned {
                    Text("Wrong e-mail or passaword.").foregroundColor(.red)
                }
                if confirmPassword != password {
                    Text("Passwords are not matching.").foregroundColor(.red)
                }
            }
        }.navigationTitle("SignUp")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
