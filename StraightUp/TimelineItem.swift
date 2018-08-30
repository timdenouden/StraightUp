//
//  TimelineItem.swift
//  StraightUp
//
//  Created by Timothy DenOuden on 12/16/17.
//  Copyright © 2017 Timothy DenOuden. All rights reserved.
//

import Foundation

class TimelineItem {
    var message = "No Message Set"
    var date : Date
    var isGood = true
    
    public init() {
        date = Date()
    }
    
    public init(message: String) {
        self.message = message
        date = Date()
    }
    
    public func set(newDate: Date) {
        date = newDate
    }
    
    public func getDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        return formatter.string(from: date)
    }
}
