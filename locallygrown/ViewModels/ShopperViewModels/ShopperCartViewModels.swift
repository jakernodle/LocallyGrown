//
//  ShopperCartViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/22/22.
//

import Foundation

struct CartFarmInfo: Hashable, Codable {
    var farmId: FarmId
    var farmName: String
    var farmAddress: String
    var farmImageURL: String
}

struct ShopperCartViewListObject: Hashable {
    var farmInfo: CartFarmInfo
    var productsNumber: Int
    var totalPrice: Float
    
    var formattedPrice: String {
        return String(format: "%.2f", totalPrice)
    }
}

class ShopperCartViewModel {
    func getCartsForDisplay() -> [ShopperCartViewListObject] {
        var cartsToDisplay: [ShopperCartViewListObject] = []

        let carts = LocallyGrownShopper.shared.getCarts()
        for (_ , cart) in carts {
            let cart = ShopperCartViewListObject(farmInfo: cart.farmInfo, productsNumber: cart.items.count, totalPrice: cart.totalPrice)
            cartsToDisplay.append(cart)
        }
        
        return cartsToDisplay
    }
    
    func deleteCart(farmId: FarmId) {
        LocallyGrownShopper.shared.removeCart(farmId: farmId)
    }
}
