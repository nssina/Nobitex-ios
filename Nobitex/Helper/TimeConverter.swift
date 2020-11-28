//
//  TimeConverter.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/27/20.
//

import Foundation

class TimeConverter {
    
    static let shared = TimeConverter()
    
    func setTimestamp(epochTime: Int) -> String {
        let realSeconds = TimeInterval(epochTime)
        let myDate = Date(timeIntervalSince1970: realSeconds / 1000.0)
        let currentDate = Date()
        let epochDate = myDate

        let calendar = Calendar.current

        let currentDay = calendar.component(.day, from: currentDate)
        let currentHour = calendar.component(.hour, from: currentDate)
        let currentMinutes = calendar.component(.minute, from: currentDate)
        let currentSeconds = calendar.component(.second, from: currentDate)

        let epochDay = calendar.component(.day, from: epochDate)
        let epochMonth = calendar.component(.month, from: epochDate)
        let epochYear = calendar.component(.year, from: epochDate)
        let epochHour = calendar.component(.hour, from: epochDate)
        let epochMinutes = calendar.component(.minute, from: epochDate)
        let epochSeconds = calendar.component(.second, from: epochDate)

        if (currentDay - epochDay < 30) {
            if (currentDay == epochDay) {
                if (currentHour - epochHour == 0) {
                    if (currentMinutes - epochMinutes == 0) {
                        if (currentSeconds - epochSeconds <= 1) {
                            return String(currentSeconds - epochSeconds) + " second ago"
                        } else {
                            return String(currentSeconds - epochSeconds) + " seconds ago"
                        }

                    } else if (currentMinutes - epochMinutes <= 1) {
                        return String(currentMinutes - epochMinutes) + " minute ago"
                    } else {
                        return String(currentMinutes - epochMinutes) + " minutes ago"
                    }
                } else if (currentHour - epochHour <= 1) {
                    return String(currentHour - epochHour) + " hour ago"
                } else {
                    return String(currentHour - epochHour) + " hours ago"
                }
            } else if (currentDay - epochDay <= 1) {
                return String(currentDay - epochDay) + " day ago"
            } else {
                return String(currentDay - epochDay) + " days ago"
            }
        } else {
            return String(epochDay) + " " + getMonthNameFromInt(month: epochMonth) + " " + String(epochYear)
        }
    }


    func getMonthNameFromInt(month: Int) -> String {
        switch month {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sept"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return ""
        }
    }
}

extension Date {

    func timeAgoSinceDate(date: Date) -> String {

        // From Time
        let fromDate = date

        // To Time
        let toDate = Date()

        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }

        return "Just Now"
    }
}
