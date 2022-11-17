//
//  Delivery.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/15/22.
//

import Foundation


enum Day: Int, Codable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    
    var description : String {
        switch self {
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tues"
        case .wednesday: return "Wed"
        case .thursday: return "Thurs"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        }
    }
}

enum RecurancePeriod: String, Codable {
    case weekly = "Weekly"
    case biWeekly = "Bi-Weekly"
    case monthly = "Monthly"
}

enum PickupType: String, Codable {
    case standard = "Standard"
    case market = "Market"
    case localDelivery = "Local Delivery"
}

struct Time: Codable, Hashable {
    var hour: Int
    var minute: Int
}

struct DayAndTime: Codable, Hashable {
    var day: Day
    var pickupAvailibilityStartTime: Time
    var pickupAvailibilityEndTime: Time
    var pickupRecurancePeriod: RecurancePeriod
}

struct PickupOption: Codable, Hashable {
    var locationName: String?
    var address: String
    var daysAndTimes: [DayAndTime]
    var startDate: Date
    var endDate: Date?
}

struct PickupOptions: Codable, Hashable {
    var standardPickup: PickupOption?
    var marketPickups: [PickupOption] = []
    var localDropoffs: [PickupOption] = []
}



