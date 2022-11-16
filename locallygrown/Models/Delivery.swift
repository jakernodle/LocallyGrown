//
//  Delivery.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/15/22.
//

import Foundation


enum Day: String, Codable {
    case monday = "Mon"
    case tuesday = "Tues"
    case wednesday = "Wed"
    case thursday = "Thurs"
    case friday = "Fri"
    case saturday = "Sat"
    case sunday = "Sun"
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

struct PickupOption: Codable, Hashable {
    var type: PickupType
    var locationName: String?
    var address: String
    var pickupAvailibilityDays: [Day]
    var pickupRecurancePeriod: RecurancePeriod
    var pickupAvailibilityStartTime: String
    var pickupAvailibilityEndTime: String
}



