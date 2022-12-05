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

struct FarmReview: Codable {
    var userId: String
    var userName: String
    var ratingOutOfFive: Int
    var reviewText: String
}

struct FarmSupplierInfo: Codable, Hashable {
    var id: String
    var name: String
    var pictureURL: String
}

struct Farm : Codable {
    var id: FarmId
    
    var name: String
    var pictureURL: String
    var about: String
    var address: String
    
    var reviews: [FarmReview]?
    var averageRating: Float? //not a computed value since this could get costly, calculate on the backend
    var hasReviews: Bool {
        reviews != nil && reviews!.count > 0
    }
    
    var products: [Product]
    var farmerInfo: [FarmSupplierInfo]
    var paymentInfo: FarmDepositInfo?
    
    var pickupOptions: PickupOptions
    
    var productCategoriesDescription:String {
        //this is a set since there can be multiple products with category "meat", yet we only want meat to show once in the final string
        var categories:Set<String> = []
        for product in products {
            categories.insert(product.category.description)
        }
        return categories.map{String($0)}.joined(separator: ", ")
    }
    
    var productCategoriesArray:[String] {
        var categories:Set<String> = []
        for product in products {
            categories.insert(product.category.description)
        }
        return Array(categories)
    }
    
    var productMap:[String:[ProductBasicInfo]] {
        var map:[String:[ProductBasicInfo]] = [:]
        for product in products {
            map[product.category.description, default: []].append(product.toProductBasicInfo())
        }
        return map
    }
    
    func toShopperFarmViewFarm() -> ShopperFarmViewFarm {
        return ShopperFarmViewFarm(id: id, pictureURL: pictureURL, name: name, rating: averageRating ?? 0, reviewsCount: reviews?.count ?? 0, about: about, address: address, productCategories: productCategoriesArray, productMap: productMap, pickupOptions: pickupOptions)
    }
}

struct FarmResponse : Codable {
    var id: String
    
    var name: String
    var pictureURL: String
    var about: String
    var address: String
    
    var reviews: [FarmReview]?
    var averageRating: Float? //not a computed value since this could get costly, calculate on the backend
    
    var products: [Product]
    var farmerInfo: [FarmSupplierInfo]
    var paymentInfo: FarmDepositInfo?
    
    var pickupOptions: PickupOptions
    
    var productCategoriesDescription:String {
        var categories:Set<String> = []
        for product in products {
            categories.insert(product.category.description)
        }
        return categories.map{String($0)}.joined(separator: ", ")
    }
    
    func toFarm() -> Farm {
        return Farm(id: id, name: name, pictureURL: pictureURL, about: about, address: address, reviews: reviews, averageRating: averageRating, products: products, farmerInfo: farmerInfo, paymentInfo: paymentInfo, pickupOptions: pickupOptions)
    }
}
