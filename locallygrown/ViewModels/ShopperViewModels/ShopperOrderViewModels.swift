//
//  ShopperOrderViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/22/22.
//

import Foundation

struct ShopperOrderViewListItem: Hashable {
    var farmName: String
    var productsNumber: Int
    var totalPrice: Float
    var date: Date
}

extension ShopperOrderViewListItem {
    var formattedPrice: String {
        return String(format: "%.2f", totalPrice)
    }
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, y"
        return dateFormatter.string(from: date)
    }
}
