//
//  PaymentInfo.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/22/22.
//

import Foundation

struct CreditCard : Codable, Hashable {
    var id: String = UUID().uuidString //API - remove this
    var cardNumber: String
    var expDate: String
    var cvv: String
    var zipCode: String
    
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
