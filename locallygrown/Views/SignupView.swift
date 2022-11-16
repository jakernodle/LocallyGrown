//
//  SignupView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import SwiftUI

//191952635625-ncu40r9iqep4uqqjuu21ui7h3lmk7d27.apps.googleusercontent.com
import GoogleSignIn

struct SignupView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    var viewModel = AuthenticationViewModel()
    
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
                viewModel.signup(name: name, email: email, password: password)
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
            
            }) {
                Text("Login")
                    .font(.body)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
            }
            
            LabelledDivider(label: "or")
            
            Button(action: {
                viewModel.continueWithGoogle()
            }) {
                HStack {
                    Image("Google_G")
                    Text("Continue with Google")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.27)))
            .padding([.trailing, .leading], 20)
            .padding(.bottom, 8)
        }
        .onOpenURL { url in
            GIDSignIn.sharedInstance.handle(url)
        }
        .onReceive(viewModel.viewDismissalModePublisher) { shouldDismiss in
            if shouldDismiss {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
