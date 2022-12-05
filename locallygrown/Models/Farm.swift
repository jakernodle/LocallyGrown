//
//  Farm.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

struct Farm : Codable {
    let id: FarmId
    let name: String
    let pictureURL: String
    let about: String
    let address: String
    let reviewCount: Int
    let averageRating: Float? //not a computed value since this could get costly, this will be calculate on the backend
    let products: [Product]
    let farmerInfo: [FarmSupplierInfo]
    let paymentInfo: FarmDepositInfo?
    let pickupOptions: PickupOptions
    
    func toShopperFarmViewFarm() -> ShopperFarmViewFarm {
        return ShopperFarmViewFarm(id: id, pictureURL: pictureURL, name: name, rating: averageRating ?? 0, reviewsCount: reviewCount, about: about, address: address, productCategories: productCategoriesArray, productMap: productMap, pickupOptions: pickupOptions)
    }
}

struct FarmDepositInfo : Codable {
    var routingNumber: Int
    var accountNumber: Int
}

struct FarmReview: Codable {
    let userId: String
    let name: String
    let ratingOutOfFive: Int
    let reviewText: String
}

struct FarmSupplierInfo: Codable, Hashable {
    let id: String
    let name: String
    //pictures can be nil
    let pictureURL: String?
}

extension Farm {
    var hasReviews: Bool {
        reviewCount > 0
    }
    
    var productCategoriesArray:[String] {
        // this is defined as a set since there can be multiple products with category "meat", yet we only want meat to show once in the final string
        var categories:Set<String> = []
        for product in products {
            categories.insert(product.category.description)
        }
        return Array(categories)
    }
    
    var productCategoriesDescription:String {
        return productCategoriesArray.map{String($0)}.joined(separator: ", ")
    }
    
    // here we map an array of products to their respective product categories for display in a list with sections
    // the section title is by the map's key, while the sections products are held in the array
    var productMap:[String:[ProductBasicInfo]] {
        var map:[String:[ProductBasicInfo]] = [:]
        for product in products {
            map[product.category.description, default: []].append(product.toProductBasicInfo())
        }
        return map
    }
}

struct FarmResponse : Codable {
    let id: String
    let name: String
    let pictureURL: String
    let about: String
    let address: String
    let reviewCount: Int
    let averageRating: Float? //not a computed value since this could get costly, calculate on the backend
    let products: [Product]
    let farmerInfo: [FarmSupplierInfo]
    let paymentInfo: FarmDepositInfo?
    let pickupOptions: PickupOptions
    
    func toFarm() -> Farm {
        return Farm(id: id, name: name, pictureURL: pictureURL, about: about, address: address, reviewCount: reviewCount, averageRating: averageRating, products: products, farmerInfo: farmerInfo, paymentInfo: paymentInfo, pickupOptions: pickupOptions)
    }
}
