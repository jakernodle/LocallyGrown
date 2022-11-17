//
//  ShopperScheduleView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/16/22.
//

import SwiftUI

class ShopperScheduleViewModel {
    
    var pickupOption: PickupOption
    
    var currentDay: Int = 0
    var hour: Int = 0
    var minute: Int = 0
    
    var days: [String] = []
    
    init (option: PickupOption) {
        self.pickupOption = option
        
        self.currentDay = getDayInt(Date.now)
        self.hour = getHourInt(Date.now)
        self.minute = getMinuteInt(Date.now)
        
        self.days = getDays(startDate: option.startDate, endDate: option.endDate, daysAndTimes: option.daysAndTimes)
    }
    
    func getDayInt(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: date)
    }
    
    func getHourInt(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
    }
    
    func getMinuteInt(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: date)
    }
    
    func getDays(startDate: Date, endDate: Date?, daysAndTimes: [DayAndTime]) -> [String] {
        var dayArray: [String] = []
        
        var dateStepper: Date = Date.now
        if dateStepper < startDate {
            dateStepper = startDate
        }
        
        func keepStepping() -> Bool {
            if endDate != nil {
                return dateStepper < endDate! && dayArray.count < 10
            }else{
                return dayArray.count < 10
            }
        }
        
        while keepStepping() {
            for dayAndTime in daysAndTimes {
                if getDayInt(dateStepper) == dayAndTime.day.rawValue {
                    dayArray.append(dayAndTime.day.description)
                }
            }
            
            dateStepper = Calendar.current.date(byAdding: DateComponents(day: 1), to: dateStepper)!
        }
        
        return dayArray
    }
    
    func getTimesForDay(){
        
    }
}

struct ShopperScheduleView: View {
    var viewModel: ShopperScheduleViewModel
    var title: String
    
    var body: some View {
        VStack{
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.days, id: \.self){day in
                        Button(action: {
                            
                        }) {
                            Text(day)
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding(8)
                                .frame(width: 100, height: 80)
                        }
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 2))
                            .padding(.horizontal, 2)
                    }
                }
            }
            List{
                
            }
        }
        .padding(.horizontal, 20)
    }
}

struct ShopperScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ShopperScheduleView(viewModel: ShopperScheduleViewModel(option: Constants.standardPickup), title: "Schedule")
    }
}
