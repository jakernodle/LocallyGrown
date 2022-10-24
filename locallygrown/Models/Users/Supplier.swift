//
//  Supplier.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

struct Supplier: User, Codable {
    var name: String
    var email: String
    var pictureURL: String?
    
    var farmId: String?
    
    func toShopperHomeViewSupplier() -> ShopperHomeViewSupplier {
        return ShopperHomeViewSupplier(name: name, pictureURL: pictureURL)
    }
}

struct SupplierResponse: User, Codable {
    var name: String
    var email: String
    var pictureURL: String?
    var farmId: String
    
    func toSupplier() -> Supplier {
        return Supplier(name: name, email: email, pictureURL: pictureURL, farmId: farmId)
    }
}
