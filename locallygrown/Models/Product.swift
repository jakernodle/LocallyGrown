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
        // Use Internationalization, as appropriate.
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
    var seasonStart: Date
    var seasonEnd: Date
}

struct Product : Codable {
    var id: String
    var name: String
    var description: String
    var pictureURL: String

    var category: ProductCategory
    var pricing: Pricing
    
    //var season: ProductSeason
    var isOffered: Bool
    
    var isAvailible: Bool {
        return isOffered //&& Date().isBetweeen(date: season.seasonStart, andDate: season.seasonEnd)
    }
    
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
    var formattedPrice: String {
        return String(format: "%.2f", price)
    }
    var unitsDescription: String //ex. /lb.
    
}

extension Date {
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
}
