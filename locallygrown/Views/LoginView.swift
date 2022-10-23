//
//  SwiftUIView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("Login for")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Local.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
            }
            .padding(.bottom, 20)

            TextField("Email", text: $email)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(.bottom, 4)

            TextField("Password", text: $password)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(.bottom, 20)
            Button(action: {
                    UserService().login(params: ["email": email, "password": password]){ result in
                        switch result {
                        case .loginSuccess:
                            print("do a thing")
                        case .loginFailed:
                            print("alert the thing is broke")
                        default:
                            break
                    }
                }
            }) {
                Text("Login")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding(.bottom, 8)
            
            Button(action: {
                    print("signup button")
            }) {
                Text("Signup")
                    .font(.body)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 20)
        }
        .padding([.leading, .trailing], 20)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
