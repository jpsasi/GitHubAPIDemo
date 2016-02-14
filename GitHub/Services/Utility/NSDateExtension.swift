//
//  NSDateExtension.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

extension NSDate {
    
    func isToday() -> Bool {
        return NSCalendar.currentCalendar().isDateInToday(self)
    }
    
    func isThisWeek() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        /* Today's */
        let todaysComponent = calendar.components([.WeekOfMonth], fromDate: NSDate())
        let todaysWeek = todaysComponent.weekOfMonth
        
        /* Current Date Object value */
        let currentDateComponent = calendar.components([.WeekOfMonth], fromDate: self)
        let currentWeek = currentDateComponent.weekOfMonth
        return todaysWeek == currentWeek
    }
    
    func isLastWeek() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        /* Today's Week */
        let todaysComponent = calendar.components([.WeekOfMonth], fromDate: NSDate())
        let todaysWeek = todaysComponent.weekOfMonth
        
        /* Current Date Object value */
        let currentDateComponent = calendar.components([.WeekOfMonth], fromDate: self)
        let currentWeek = currentDateComponent.weekOfMonth
        return (todaysWeek - 1) == currentWeek
    }
    
    func isNextWeek() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        /* Today's Week */
        let todaysComponent = calendar.components([.WeekOfMonth], fromDate: NSDate())
        let todaysWeek = todaysComponent.weekOfMonth
        
        /* Current Date Object value */
        let currentDateComponent = calendar.components([.WeekOfMonth], fromDate: self)
        let currentWeek = currentDateComponent.weekOfMonth
        return (todaysWeek + 1) == currentWeek
    }
    
    func shortDateString() -> String {
        let dateFormatter = NSDateFormatter()
        
        if isToday() {
            dateFormatter.dateFormat = "hh:mm a"
        } else if isThisWeek() {
            dateFormatter.dateFormat = "EEEE"
        } else {
            dateFormatter.dateFormat = "dd-MM-yyyy"
        }
        
        return dateFormatter.stringFromDate(self)
    }
    
    func fullDateString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MMM dd yyyy hh:mm a"
        return dateFormatter.stringFromDate(self)
        
    }
}

extension String {
    
    func iso8601StringToDate() -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return dateFormatter.dateFromString(self)
    }
}