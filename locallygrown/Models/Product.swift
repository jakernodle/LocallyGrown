//
//  Product.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum ProductCategory: Codable {
    case produce(id: String)
    case dairy(id: String)
    case meat(id: String)
    case prepared(id: String)
    case bakery(id: String)
    case other(id: String)
    
    var description : String {
        switch self {
        case .produce: return "Produce"
        case .dairy: return "Dairy"
        case .meat: return "Meat"
        case .prepared: return "Prepared"
        case .bakery: return "Bakery"
        case .other: return "Other"
        }
    }
}

struct ProductSeason : Codable {
    let seasonStart: Date
    let seasonEnd: Date
}

struct Product : Codable {
    let id: String
    let name: String
    let description: String
    let pictureURL: String
    let category: ProductCategory
    let pricing: Pricing
    let isOffered: Bool
    
    //This feature is under consideration
    //var season: ProductSeason
    //var isAvailible: Bool {
    //    return isOffered && Date().isBetweeen(date: season.seasonStart, andDate: season.seasonEnd)
    //}
    
    func toProductBasicInfo() -> ProductBasicInfo {
        return ProductBasicInfo(id: id, name: name, description: description, price: pricing.cost, pictureURL: pictureURL, unitsDescription: pricing.units.description)
    }
}

struct ProductBasicInfo: Codable, Hashable {
    var id: String
    var name: String
    var description: String
    var price: Float
    var pictureURL: String
    var unitsDescription: String //ex. /lb.
}

extension ProductBasicInfo {
    var formattedPrice: String {
        return String(format: "%.2f", price)
    }
}

//This feature is under consideration
//extension Date {
//    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
//        return date1.compare(self) == self.compare(date2)
//    }
//}
