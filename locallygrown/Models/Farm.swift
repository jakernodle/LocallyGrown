//
//  Farm.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

struct FarmDepositInfo : Codable {
    var routingNumber: Int
    var accountNumber: Int
}

struct Farm : Codable {
    var id: String
    
    var name: String
    var pictureURL: String
    var about: String
    var address: String
    
    var products: [Product]
    var farmers: [Supplier]
    var paymentInfo: FarmDepositInfo?
    
    var productCategoriesDescription:String {
        var categories:Set<String> = []
        for product in products {
            categories.insert(product.category.description)
        }
        return categories.map{String($0)}.joined(separator: ", ")
    }
    
    func toShopperHomeViewFarm() -> ShopperHomeViewFarm {
        var homeViewSuppliers: [ShopperHomeViewSupplier] = []
        for farmer in farmers {
            homeViewSuppliers.append(farmer.toShopperHomeViewSupplier())
        }
        
        return ShopperHomeViewFarm(farmId: id, name: name, pictureURL: pictureURL, about: about, address: address, suppliers: homeViewSuppliers, categories: productCategoriesDescription)
    }
}
