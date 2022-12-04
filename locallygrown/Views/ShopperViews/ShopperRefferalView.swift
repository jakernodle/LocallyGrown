//
//  ShopperRefferalView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/30/22.
//

import SwiftUI

struct ShopperRefferalView: View {
    
    @Environment (\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var location: String = ""
    
    var body: some View {
        VStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .tint(.black)
            }
            .padding(.top, 20)
            .frame(maxWidth:.infinity, alignment: .leading)
            
            HStack {
                Text("Refer for")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Local.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
            }
            .padding(.bottom, 20)

            TextField("Farm name", text: $name)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(.bottom, 4)

            TextField("Farm email", text: $email)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(.bottom, 4)
            
            TextField("What city is this farm located in?", text: $location)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(.bottom, 20)
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Submit")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding(.bottom, 20)
        }
        .padding([.leading, .trailing], 20)
    }
}

struct ShopperRefferalView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperRefferalView()
    }
}
