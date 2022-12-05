//
//  ShoppingCartItem.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

typealias ProductId = String
typealias Units = Float

struct Cart: Codable, Hashable {
    let farmInfo: CartFarmInfo
    var items: [ProductId:ShoppingCartItem]
}

extension Cart {
    var itemsAmount: String {
        String(items.count)
    }
    var isEmpty: Bool {
        items.count > 0
    }
    
    var totalPrice: Float {
        return items.values.reduce(0.0) { partialResult, ShoppingCartItem in
            partialResult + ShoppingCartItem.price
        }
    }
    
    var formattedTotalPrice: String {
        String(format: "%.2f", totalPrice)
    }
    
    func hasProduct(productId:ProductId) -> Bool {
        return items[productId] != nil
    }
    
    func amountOfProductString(productId:ProductId) -> String {
        //here we use the .clean Float extension to remove any trailing ".0's"
        guard let product = items[productId] else { return "0" }
        return product.unitsInCart.clean
    }
    
    func amountOfProductForProductView(productId:ProductId) -> Float {
        //here we use the .clean Float extension to remove any trailing ".0's"
        guard let product = items[productId] else { return 1 }
        return product.unitsInCart
    }
    
    mutating func addToCart(productId:ProductId, item:ShoppingCartItem){
        items[productId] = item
    }
}

struct ShoppingCartItem : Codable, Hashable {
    var productInfo: ProductBasicInfo
    var unitsInCart: Float
}

extension ShoppingCartItem {
    var formattedUnitsInCart: String {
        return unitsInCart.clean
    }
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
