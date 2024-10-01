//
//  LoginPage.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI

// represents login view
struct LoginPage: View {
    @ObservedObject var userViewModel: UserViewModel
    
    // login info
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
//        NavigationStack {
        VStack(spacing: 8) {
            Spacer()
            Text("**Log In**")
                .font(.largeTitle)
        
            HStack {
                Text("New User?")
                NavigationLink {
                    // link to sign up page
                    SignUpPage(userViewModel: userViewModel)
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Sign Up")
                        .underline()
                        .foregroundColor(Color.blue)
                }
            }
            .padding(.bottom, 10)
            
            // textfields for user to enter information
            VStack(alignment: .leading, spacing: 15) {
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
                    // connect to firebase console and get user info from login info
                    userViewModel.login(email: email, password: password){
                        // user exist
                        if userViewModel.currUser != nil {
                            DispatchQueue.main.async {
                                userViewModel.isLoggedIn = true
                            }
                        }
                    }
                }) {
                    Text("**Login**")
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .padding(.top)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
//    }
}

#Preview {
    LoginPage(userViewModel: UserViewModel())
}
