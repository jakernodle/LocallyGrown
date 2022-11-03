//
//  ShoppingCartItem.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

struct Cart: Codable {
    var farmName: String

    var items: [ShoppingCartItem]
    var itemsAmount: String {
        String(items.count)
    }
    var totalPrice: Float {
        return items.reduce(0.0) { partialResult, ShoppingCartItem in
            partialResult + ShoppingCartItem.price
        }
    }
}

struct ShoppingCartItem : Codable {
    var productInfo: ProductBasicInfo
    var unitsInCart: Float
    var price: Float {
        return unitsInCart * productInfo.price
    }
    var formattedPrice: String {
        String(format: "%.2f", price)
    }
}

struct ShoppingCartItemResponse : Codable {
    var productInfo: ProductBasicInfo
    var unitsInCart: Float
    
    func toShoppingCartItem() -> ShoppingCartItem {
        return ShoppingCartItem(productInfo: productInfo, unitsInCart: unitsInCart)
    }
}
