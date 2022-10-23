//
//  Shopper.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

struct ShopperPaymentInfo : Codable {
    
}

struct Shopper : User, Codable {
    var name: String
    var email: String
    var pictureURL: String?
    var favoriteFarmIds: [String]
    var paymentInfo: ShopperPaymentInfo?
    var orders: [Order]?
    var carts: [Order]?
}

// from the api after login
struct ShopperResponse: Codable {
    var name: String
    var email: String
    var pictureURL: String?
    var favoriteFarmIds: [String]
    var paymentInfo: ShopperPaymentInfo?
    var orders: [Order]?
    var carts: [Order]?
    
    func toShopper() -> Shopper {
        return Shopper(name: name, email: email, pictureURL: pictureURL, favoriteFarmIds: favoriteFarmIds, paymentInfo: paymentInfo, orders: orders, carts: carts)
    }
}
