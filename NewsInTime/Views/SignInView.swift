//
//  SignInView.swift
//  NewsInTime
//
//  Created by Leonardo Soares on 24/04/21.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var invalidEmail = false
    @State var invalidPassword = false

    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                Form {
                    TextField("E-Mail", text: $email)
                    TextField("Password", text: $password)
                    Button(action: {
                        if email == "" {
                            self.invalidEmail = true
                        }
                        if password == "" {
                            self.invalidPassword = true
                        }
                    }, label: {
                        Text("Sign In")
                    })
                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("SignUp")
                        })
                    if invalidEmail {
                        Text("Invalid e-mail.").foregroundColor(.red)
                    }
                    if invalidPassword {
                        Text("Invalid password.").foregroundColor(.red)
                    }
                }
            }.navigationTitle("SignIn")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
