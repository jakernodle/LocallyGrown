//
//  ShopperCartViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/22/22.
//

import Foundation

struct CartFarmInfo: Hashable, Codable {
    let farmId: FarmId
    let farmName: String
    let farmAddress: String
    let farmImageURL: String
}

struct ShopperCartViewListObject: Hashable {
    let farmInfo: CartFarmInfo
    let productsNumber: Int
    let totalPrice: Float
}

extension ShopperCartViewListObject {
    var formattedPrice: String {
        return String(format: "%.2f", totalPrice)
    }
}

class ShopperCartViewModel {
    func getCarts() -> [Cart] {
        var cartsForView: [Cart] = []

        let carts = LocallyGrownShopper.shared.getCarts()
        for (_ , cart) in carts {
            cartsForView.append(cart)
        }
        
        return cartsForView
    }
    
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
