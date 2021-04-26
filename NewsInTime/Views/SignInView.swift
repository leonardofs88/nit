//
//  SignInView.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct SignInView: View {

    @EnvironmentObject var userAuth: UserAuth

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
                            Service.sharedInstance.authentication(
                                email: email,
                                password: password,
                                for: .signIn) { isSignedIn in
                                self.isSignedIn = isSignedIn
                                self.userAuth.isLoggedin = isSignedIn
                            }
                        }
                    }, label: {
                        Text("Sign In")
                    })
                    NavigationLink(
                        destination: SignUpView().environmentObject(userAuth),
                        label: {
                            Text("SignUp")
                        })
                    if invalidEmail {
                        Text("Invalid e-mail.").foregroundColor(.red)
                    }
                    if invalidPassword {
                        Text("Invalid password.").foregroundColor(.red)
                    }
                    if let isSigned = self.isSignedIn, !isSigned {
                        Text("Error in request").foregroundColor(.red)
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
