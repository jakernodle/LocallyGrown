//
//  ShopperFarmView.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import SwiftUI
import Kingfisher

struct ShopperFarmViewProduct {
    var name: String
    var description: String
    var price: Float
    var unitsDescription: String //ex. /lb. 
}

struct ShopperFarmViewFarm {
    var pictureURL: String
    var name: String
    var rating: Float
    var reviewsCount: Int
    var about: String
    var productCategories: [String]
    var productMap: [String: [ShopperFarmViewProduct]]
}

struct ShopperFarmView: View {
    
    //var farmInfo: []
    
    var body: some View {
        VStack {
            KFImage(URL(string: "https://foodtank.com/wp-content/uploads/2020/04/COVID-19-Relief_Small-Farms-.jpg"))
                .frame(width: 50, height: 180)
                .frame(maxWidth: .infinity)
                .cornerRadius(0)
            
            Text("Happy Farms")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.top, 6)
            
            HStack {
                Image(systemName: "star.fill")
                Text("4.7 (100 reviews)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Happy Farms")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body)
            
            List {
                Section(header: Text("Header")) {
                    Text("Row")
                }
                .headerProminence(.increased)
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct ShopperFarmView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperFarmView()
    }
}
