//
//  ShopperFavoritesView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/24/22.
//

import SwiftUI

struct ShopperFavoritesView: View {
    @ObservedObject var viewModel = ShopperFarmListViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.favoritesState {
            case .idle:
                Color.clear.onAppear(perform: viewModel.loadFavorites)
            case .loading:
                ScrollView {
                    ProgressView()
                        .padding()
                }
                .frame(height: .infinity)
            case .failed(let error):
                let _  = print(error)
                //TODO: display error page
                Color.clear.onAppear(perform: viewModel.loadFavorites)
                ProgressView()
            case .loaded(let farms):
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 0){
                        FarmsListView(farms: farms, viewModel: viewModel)
                    }
                }
                .frame(height: .infinity)
            }
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
