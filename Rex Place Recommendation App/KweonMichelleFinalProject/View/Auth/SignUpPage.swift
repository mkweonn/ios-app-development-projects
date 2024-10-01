//
//  SignUpPage.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI

// represents the SignUpPage
struct SignUpPage: View {
    @ObservedObject var userViewModel: UserViewModel
    
    // sign up info
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
//    @State private var confirmPass: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                Spacer()
                Text("**Create New \nAccount**")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                
                HStack {
                    Text("Already Registered?")
                    NavigationLink {
                        // link to login page
                        LoginPage(userViewModel: userViewModel)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Log In")
                            .underline()
                            .foregroundColor(Color.blue)
                    }
                }
                .padding(.bottom, 10)
                
                // textfields for user to enter information
                // <<future>>: add keyboard popup
                VStack(alignment: .leading, spacing: 15) {
                    Text("**NAME**")
                        .foregroundColor(Color(red:0.3, green: 0.3, blue: 0.3))
                    TextField("First Last", text: $name)
                        .padding()
                        .background(Rectangle().stroke())
                    Text("**EMAIL**")
                        .foregroundColor(Color(red:0.3, green: 0.3, blue: 0.3))
                    TextField("firstLast @email.com", text: $email)
                        .padding()
                        .background(Rectangle().stroke())
                    Text("**PASSWORD**")
                        .foregroundColor(Color(red:0.3, green: 0.3, blue: 0.3))
                    SecureField("********", text: $password)
                        .padding()
                        .background(Rectangle().stroke())
                    
                    Button(action: {
                        // connect to firebase console and create user auth
                        userViewModel.signUp(name: name, email: email, password: password) {
                            // user created -> go to main page
                            if userViewModel.currUser != nil {
    //                            DispatchQueue.main.async {
                                    userViewModel.isLoggedIn = true
    //                            }
                            }
                        }
                    }) {
                        Text("**Sign Up**")
                            .padding()
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .padding(.top)
                    }
                   // <<future>>: add sign in with google option
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    SignUpPage(userViewModel: UserViewModel())
}
