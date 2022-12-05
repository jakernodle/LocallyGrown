//
//  ShopperScheduleView.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/16/22.
//

import SwiftUI

struct DayAndTimes: Hashable {
    var date: Date
    var dayOfWeek: String
    var dateString: String
    
    var startTime: Time
    var endTime: Time
    
    var timeWindowList: [String] {
        var times:[String] = []
        
        var temp = startTime
        print(temp)
        print(endTime)
        while temp < endTime {
            var timeWindowString = temp.description
            print(timeWindowString)
            temp.incrementThirtyMinutes()
            
            timeWindowString += " - \(temp.description)"
            print(timeWindowString)
            times.append(timeWindowString)
        }
        print("returning times")
        print(times)
        
        return times
    }
}

class ShopperScheduleViewModel {
    
    var pickupOption: PickupOption
    
    //var currentDay: Int = 0
    //var hour: Int = 0
    //var minute: Int = 0
    
    var days: [DayAndTimes] = []
    
    init (option: PickupOption) {
        print("init for ShopperScheduleViewModel")
        self.pickupOption = option
        
        //self.currentDay = getDayOfWeekInt(Date.now)
        //self.hour = getHourInt(Date.now)
        //self.minute = getMinuteInt(Date.now)
        
        self.days = getPickupDays(availibleDays: option.availibleDays)
    }
    
    func getMonthString(_ date: Date) -> String {
        let calendar = Calendar.current
        let monthInt = calendar.component(.month, from: date)
        let months = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
        return months[monthInt-1]
    }
    
    func getDayOfWeekInt(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: date)
    }
    
    func getDayOfMonthInt(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    func getHourInt(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
    }
    
    func getMinuteInt(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: date)
    }
    
    func getPickupDays(availibleDays: [RecurringAvailibileDayAndTime]) -> [DayAndTimes] {
        var allDays:[DayAndTimes] = []
        for availibleDay in availibleDays {
            let days = getDaysForRecurringTime(availibleDayRecurring: availibleDay)
            print("days for - \(availibleDay.day.description)")
            print(days)

            allDays.append(contentsOf: days)
        }
        
        let sortedDays = allDays.sorted(by: { (a, b) in
            a.date < b.date
        })
        
        return sortedDays
    }
    
    
    func getDaysForRecurringTime(availibleDayRecurring: RecurringAvailibileDayAndTime) -> [DayAndTimes] {
        var dayArray: [DayAndTimes] = []
        
        var dateStepper: Date = Date.now
        
        //if there is an end date and it has passed, return []
        if availibleDayRecurring.endDate != nil && dateStepper > availibleDayRecurring.endDate! {
            return []
        }
        
        //if the pickup "season" or farmers market hasent started yet set the startDate
        if dateStepper < availibleDayRecurring.startDate {
            dateStepper = availibleDayRecurring.startDate
        }
        
        //set the date stepper to closest availible day
        while getDayOfWeekInt(dateStepper) != availibleDayRecurring.day.rawValue {
            dateStepper = Calendar.current.date(byAdding: .day, value: 1, to: dateStepper)!
        }
        
        //keep stepping as long as you havent passed the endDate or the array hasn't gotten too large
        func keepStepping() -> Bool {
            if availibleDayRecurring.endDate != nil {
                let endDateEndOfDay = Calendar.current.date(byAdding: .day, value: 1, to: availibleDayRecurring.endDate!)!
                return dateStepper <= endDateEndOfDay && dayArray.count < 10
            }else{
                return dayArray.count < 10
            }
        }
        
        //step and append the data
        while keepStepping() {
            let dateString = "\(getMonthString(dateStepper)) \(getDayOfMonthInt(dateStepper))"
            var dayName = availibleDayRecurring.day.description
            if(Calendar.current.isDateInToday(dateStepper)){
                dayName = "Today"
            }
            let day = DayAndTimes(date: dateStepper, dayOfWeek: dayName, dateString: dateString, startTime: availibleDayRecurring.pickupAvailibilityStartTime, endTime: availibleDayRecurring.pickupAvailibilityEndTime)
            dayArray.append(day)
            
            switch availibleDayRecurring.pickupRecurancePeriod {
            case .weekly:
                dateStepper = Calendar.current.date(byAdding: .day, value: 7, to: dateStepper)!
            case .biWeekly:
                dateStepper = Calendar.current.date(byAdding: .day, value: 14, to: dateStepper)!
            }
        }
        
        return dayArray
    }
}

struct ShopperScheduleView: View {
    @Environment (\.presentationMode) var presentationMode

    var viewModel: ShopperScheduleViewModel
    @State var selectedDay: DayAndTimes? = nil
    @Binding var selectedDateTime: String?

    var title: String
    
    var body: some View {
        VStack{
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .tint(.black)
            }
            .padding(.top, 20)
            .padding(.leading, 20)
            .frame(maxWidth:.infinity, alignment: .leading)
            
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.days, id: \.self){day in
                        ShopperScheduleSelectDayButton(action: {
                            selectedDay = day
                        }, selected: selectedDay == day, dayOfWeek: day.dayOfWeek, dateString: day.dateString)
                    }
                }
            }
            List{
                ForEach(selectedDay?.timeWindowList ?? [], id: \.self){ timeWindow in
                    Button(action: {
                        selectedDateTime = "\(selectedDay?.dateString ?? "No date selected") @ \(timeWindow)"
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(timeWindow)
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.horizontal,8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .padding(.top, 12)
        }
        .onAppear(){
            selectedDay = viewModel.days[0]
            print("selecting day")
            print(viewModel.days[0])
        }
    }
}

struct ShopperScheduleSelectDayButton: View {
    var action: () -> Void
    var selected: Bool
    var dayOfWeek: String
    var dateString: String
        
    var body: some View {
        if selected == true {
            Button(action: {
                action()
            }) {
                VStack {
                    Text(dayOfWeek)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.horizontal,8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(dateString)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(.horizontal,8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 110, height: 80)
            }
                .background(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.16)))
                .cornerRadius(8)
                .padding(.leading, 20)
        }else{
            Button(action: {
                action()
            }) {
                VStack {
                    Text(dayOfWeek)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.horizontal,8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(dateString)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(.horizontal,8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 110, height: 80)
            }
                .background(Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.06)))
                .cornerRadius(8)
                .padding(.leading, 20)
        }
    }
}

//struct ShopperScheduleView_Previews: PreviewProvider {
    //var string: String? = nil
    //static var previews: some View {
        //ShopperScheduleView(viewModel: ShopperScheduleViewModel(option: Constants.standardPickup), selectedTime: Binding<string>, title: "Schedule")
    //}
//}
