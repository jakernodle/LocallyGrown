//
//  SignupView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import SwiftUI

struct SignupView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("Signup for")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Local.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
            }
            .padding(.bottom, 20)

            TextField("First Name", text: $name)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 4)

            TextField("Email", text: $email)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 4)

            TextField("Password", text: $password)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding([.leading, .trailing, .bottom], 20)
            Button(action: {
                    print("signup button")
            }) {
                Text("Signup")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding([.trailing, .leading], 20)
            .padding(.bottom, 8)

            
            Button(action: {
                    print("signup button")
            }) {
                Text("Login")
                    .font(.body)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 20)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
