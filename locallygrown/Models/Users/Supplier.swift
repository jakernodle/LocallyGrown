//
//  Supplier.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

struct Supplier: User, Codable {
    var id: String
    var name: String
    var email: String
    var pictureURL: String?
    
    var farmId: String?
}

struct SupplierResponse: User, Codable {
    var id: String
    var name: String
    var email: String
    var pictureURL: String?
    var farmId: String
    
    func toSupplier() -> Supplier {
        return Supplier(id: id, name: name, email: email, pictureURL: pictureURL, farmId: farmId)
    }
}
