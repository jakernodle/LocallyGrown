//
//  File.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum OrderType : Codable {
    case delivery(id: String)
    case pickup(id: String) 
}

struct Order : Codable {
    var id: String
    var shopperId: String
    var farmId: String
    var sharedShoppers: [Shopper]
    var shoppingCart: [ShoppingCartItem]
    var orderType: OrderType
    var completed: Bool
    
    var totalPrice: Float {
        return shoppingCart.reduce(0.0) { partialResult, ShoppingCartItem in
            partialResult + ShoppingCartItem.price
        }
    }
}
