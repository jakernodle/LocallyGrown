//
//  ContentView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/18/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Locally")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                Text("Grown.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.bottom, 20)

            Button(action: {}) {
                HStack {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 40))
                    VStack(alignment: .leading) {
                        Text("For Farmers")
                            .foregroundColor(.black)
                            .font(.title)
                        Text("Get orders placed by shoppers. Prepare it for pickup and we'll do the rest.")
                            .foregroundColor(.black)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
            }
            .padding([.trailing, .leading,.bottom], 20)

            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                HStack {
                    Image(systemName: "bag.fill")
                        .foregroundColor(.brown)
                        .font(.system(size: 40))
                    VStack(alignment: .leading) {
                        Text("For Shoppers")
                            .foregroundColor(.black)
                            .font(.title)
                        Text("See whats being grown near you. Order for pickup or have food delivered.")
                            .foregroundColor(.black)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
            }
            .padding([.trailing, .leading,.bottom], 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
