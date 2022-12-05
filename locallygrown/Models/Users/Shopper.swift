//
//  Shopper.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

typealias FarmId = String

// Impl of User
struct Shopper : User, Codable {
    var id: String
    var name: String
    var email: String
    var pictureURL: String?
    
    // Not really any other better place for these to go, but this field on Shopper model should never extend past just a set of favorite ids and orders
    // We use a set because the .contains function (used for the home feed like button) is o(1)
    var favoriteFarmIds: Set<FarmId> = Set<FarmId>()
    var orders: [Order] = []

    // Later these will be abstracted and accessed by their id's to simplify the Shopper Object
    var paymentInfo: ShopperPaymentInfo = ShopperPaymentInfo()
    var carts: [FarmId:Cart] = [:]
}

// from the api after login
struct ShopperResponse: Codable {
    var id: String
    var name: String
    var email: String
    var pictureURL: String?
    var favoriteFarmIds: Set<FarmId>
    var paymentInfo: ShopperPaymentInfo
    
    func toShopper() -> Shopper {
        return Shopper(id: id, name: name, email: email, pictureURL: pictureURL, favoriteFarmIds: favoriteFarmIds, paymentInfo: paymentInfo, carts: [:])
    }
}
