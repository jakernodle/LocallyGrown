//
//  ShopperHomeViewModels.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/20/22.
//

import Foundation

struct ShopperHomeViewSupplier {
    var name: String
    var pictureURL: String?
}

struct ShopperHomeViewFarm {
    var farmId: String
    var name: String
    var pictureURL: String
    var suppliers: [ShopperHomeViewSupplier]
    var categories: String
}
