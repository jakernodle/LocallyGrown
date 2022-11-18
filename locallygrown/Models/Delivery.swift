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
}

enum PickupType: String, Codable {
    case standard = "Standard"
    case market = "Market"
    case localDelivery = "Local Delivery"
}

struct Time: Codable, Hashable {
    var hour: Int
    var minute: Int
    var description:String {
        var formattedMinute = "\(minute)"
        if minute < 10 {
            formattedMinute = "0\(minute)"
        }
        
        if hour >= 12 {
            if hour > 12 {
                return "\(hour-12):\(formattedMinute) PM"
            }else{
                return "\(hour):\(formattedMinute) PM"
            }
        }else{
            if hour == 0 {
                return "12:\(formattedMinute) AM"
            }else {
                return "\(hour):\(formattedMinute) AM"
            }
        }
    }
    
    static func < (lhs: Time, rhs: Time) -> Bool {
        //convert hour and minute(adding a leading 0 for numbers<10) in string, convert to int, compare
        var leftMinute = "\(lhs.minute)"
        if lhs.minute < 10 {
            leftMinute = "0\(lhs.minute)"
        }
        
        var rightMinute = "\(rhs.minute)"
        if rhs.minute < 10 {
            rightMinute = "0\(rhs.minute)"
        }
        
        guard let left = Int("\(lhs.hour)\(leftMinute)") else { return false }
        guard let right = Int("\(rhs.hour)\(rightMinute)") else { return false }
        
        return left < right
    }
    
    mutating func incrementThirtyMinutes(){
        if minute >= 30 {
            if hour >= 23 {
                hour = 0
            }else {
                hour += 1
            }
            minute -= 30
        }else{
            minute += 30
        }
    }
}

struct RecurringAvailibileDayAndTime: Codable, Hashable {
    var day: Day
    var pickupAvailibilityStartTime: Time
    var pickupAvailibilityEndTime: Time
    var pickupRecurancePeriod: RecurancePeriod
    var startDate: Date
    var endDate: Date?
}

struct PickupOption: Codable, Hashable {
    var locationName: String?
    var address: String
    var availibleDays: [RecurringAvailibileDayAndTime]
}

struct PickupOptions: Codable, Hashable {
    var standardPickup: PickupOption?
    var marketPickups: [PickupOption] = []
    var localDropoffs: [PickupOption] = []
}



