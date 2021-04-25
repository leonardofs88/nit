//
//  SignUpView.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct SignUpView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var invalidEmail = false
    @State var invalidPassword = false
    @State var invalidName = false
    @State var isSignedUp: Bool?

    var body: some View {
            VStack {
                Image("Logo")
                Form {
                    TextField("Name", text: $name)
                    TextField("E-Mail", text: $email)
                    TextField("Password", text: $password)
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
                            Service.sharedInstance.signUp(
                                name: self.name,
                                password: self.password,
                                email: self.email) { isSignedUp in
                                self.isSignedUp = isSignedUp
                            }
                        }
                    }, label: {
                        Text("Sign Up")
                    })
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
                        Text("Error in request").foregroundColor(.red)
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
