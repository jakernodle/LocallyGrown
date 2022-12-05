//
//  File.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum OrderType : Codable {
    case delivery
    case pickup
}

enum OrderState : Codable {
    case idle
    case placed
    case canceledByFarm
    case readyForPickup
    case readyForDelivery
    case outForDelivery
    case completed
}

struct Order : Codable {
    let id: String
    let farmId: String
    
    // primaryShopperId id is the original creator of the cart
    // secondaryShopperIds are shoppers invited to the order by the primary shopper
    let primaryShopperId: String
    let secondaryShopperIds: [String]
    
    let cart: Cart
    let orderType: OrderType
    
    //This is the only mutable value of order as all other values are set only once when the order is created
    var orderState: OrderState
}

extension Order {
    var totalPrice: Float {
        return shoppingCart.reduce(0.0) { partialResult, ShoppingCartItem in
            partialResult + ShoppingCartItem.price
        }
    }
}
