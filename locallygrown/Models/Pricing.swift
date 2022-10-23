//
//  Pricing.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum UnitType : Codable {
    case perUnit
    case perOz
    case perLb
    
    var description : String {
        switch self {
        case .perUnit: return ""
        case .perOz: return "/oz"
        case .perLb: return "/lb"
        }
    }
}

struct Pricing : Codable {
    var cost: Float
    var units: UnitType
}
