//
//  ShoppingCartItem.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

struct ShoppingCartItem : Codable {
    var product: Product //make this an id or DTO
    var units: Float
    var price: Float {
        return units * product.pricing.cost
    }
}
