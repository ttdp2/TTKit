//
//  DateUtility.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import Foundation

struct DateUtility {
    
    static func utcDateTime(from string: String) -> Date? {
        return utcDateTimeFormatter.date(from: string)
    }
    
    static func utcDate(from string: String) -> Date? {
        return utcDateFormatter.date(from: string)
    }
    
    static func localDateTime(from string: String) -> Date? {
        return localDateTimeFormatter.date(from: string)
    }
    
    static func localDate(from string: String) -> Date? {
        return localDateFormatter.date(from: string)
    }
    
    fileprivate static let utcDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    fileprivate static let utcDateTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    fileprivate static let localDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    fileprivate static let localDateTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        /*
         dateFormatter.dateStyle = .medium
         dateFormatter.timeStyle = .short
         */
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
}

extension Date {
    
    static var referenceDateTime: Date {
        return Date(timeIntervalSinceReferenceDate: 0)
    }
    
    var utcDateString: String {
        return DateUtility.utcDateFormatter.string(from: self)
    }
    
    var utcDateTimeString: String {
        return DateUtility.utcDateTimeFormatter.string(from: self)
    }
    
    var localDateString: String {
        return DateUtility.localDateFormatter.string(from: self)
    }
    
    var localDateTimeString: String {
        return DateUtility.localDateTimeFormatter.string(from: self)
    }
    
}
