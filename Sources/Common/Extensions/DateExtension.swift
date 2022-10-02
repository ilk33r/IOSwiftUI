//
//  DateExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation

public extension Date {
    
    // MARK: - Date Creating
    
    static func date(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
        let calendar = Calendar.current
        return calendar.date(from: components)
    }

    static func date(string dateString: String, format: String, locale: Locale = .current) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        
        return formatter.date(from: dateString)
    }
    
    // MARK: - Date By Adding

    func date(byAddingYears years: Int) -> Date? {
        var components = DateComponents()
        components.year = years
        
        let calendar = Calendar.current
        return calendar.date(byAdding: components, to: self)
    }
    
    func date(byAddingMonths months: Int) -> Date? {
        var components = DateComponents()
        components.month = months
        
        let calendar = Calendar.current
        return calendar.date(byAdding: components, to: self)
    }
    
    func date(byAddingWeeks weeks: Int) -> Date? {
        var components = DateComponents()
        components.weekOfYear = weeks
        
        let calendar = Calendar.current
        return calendar.date(byAdding: components, to: self)
    }

    func date(byAddingDays days: Int) -> Date? {
        var components = DateComponents()
        components.day = days
        
        let calendar = Calendar.current
        return calendar.date(byAdding: components, to: self)
    }
    
    func date(byAddingHours hours: Int) -> Date? {
        var components = DateComponents()
        components.hour = hours
        
        let calendar = Calendar.current
        return calendar.date(byAdding: components, to: self)
    }
    
    func date(byAddingMinutes minutes: Int) -> Date? {
        var components = DateComponents()
        components.minute = minutes
        
        let calendar = Calendar.current
        return calendar.date(byAdding: components, to: self)
    }
    
    func date(byAddingSeconds seconds: Int) -> Date? {
        var components = DateComponents()
        components.second = seconds
        
        let calendar = Calendar.current
        return calendar.date(byAdding: components, to: self)
    }

    // MARK: - Date By Subtracting
    
    func date(bySubtractingYears years: Int) -> Date? {
        return self.date(byAddingYears: -1 * years)
    }
    
    func date(bySubtractingMonths months: Int) -> Date? {
        return self.date(byAddingMonths: -1 * months)
    }
    
    func date(bySubtractingWeeks weeks: Int) -> Date? {
        return self.date(byAddingWeeks: -1 * weeks)
    }

    func date(bySubtractingDays days: Int) -> Date? {
        return self.date(byAddingDays: -1 * days)
    }
    
    func date(bySubtractingHours hours: Int) -> Date? {
        return self.date(byAddingHours: -1 * hours)
    }
    
    func date(bySubtractingMinutes minutes: Int) -> Date? {
        return self.date(byAddingMinutes: -1 * minutes)
    }
    
    func date(bySubtractingSeconds seconds: Int) -> Date? {
        return self.date(byAddingSeconds: -1 * seconds)
    }

    // MARK: - Date Formatting

    func string(format: String, locale: Locale = .current) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        
        return formatter.string(from: self)
    }
}
