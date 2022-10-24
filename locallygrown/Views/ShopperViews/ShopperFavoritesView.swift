//
//  ShopperFavoritesView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/24/22.
//

import SwiftUI

struct ShopperFavoritesView: View {
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 0){
                    FarmsList()
                }
            }
            .frame(height: .infinity)
        }
        .navigationBarTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ShopperFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperFavoritesView()
    }
}
