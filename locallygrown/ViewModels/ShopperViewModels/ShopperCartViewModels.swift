//
//  ShopperCartViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/22/22.
//

import Foundation

struct ShopperCartViewModel: Hashable {
    var farmName: String
    var productsNumber: Int
    var totalPrice: Float
    
    var formattedPrice: String {
        return String(format: "%.2f", totalPrice)
    }
}
