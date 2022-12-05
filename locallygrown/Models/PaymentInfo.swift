//
//  PaymentInfo.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/22/22.
//

import Foundation

struct CreditCard : Codable, Hashable {
    var id = UUID().uuidString // id is currently being initialized for testing purposes
    let cardNumber: String
    let expDate: String
    let cvv: String
    let zipCode: String
}

extension CreditCard {
    var formattedCardNumber: String {
        let last4 = cardNumber.suffix(4)
        let formatted = "**** " + last4
        return formatted
    }
}

struct ShopperPaymentInfo : Codable {
    var cards: [CreditCard] = []
    var selectedCard: CreditCard? = nil
}
