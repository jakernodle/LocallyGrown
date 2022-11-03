//
//  Shopper.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

typealias FarmId = String

struct ShopperPaymentInfo : Codable {
    
}

struct Shopper : User, Codable {
    var id: String
    var name: String
    var email: String
    var pictureURL: String?
    var favoriteFarmIds: [FarmId]
    var paymentInfo: ShopperPaymentInfo?
    var orders: [Order]?
    
    var cartIds: Set<FarmId>?
    var carts: [FarmId:Cart]?
}

// from the api after login
struct ShopperResponse: Codable {
    var id: String
    var name: String
    var email: String
    var pictureURL: String?
    var favoriteFarmIds: [FarmId]
    var paymentInfo: ShopperPaymentInfo?
    
    func toShopper() -> Shopper {
        return Shopper(id: id, name: name, email: email, pictureURL: pictureURL, favoriteFarmIds: favoriteFarmIds, paymentInfo: paymentInfo, orders: [], carts: [:])
    }
}
