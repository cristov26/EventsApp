//
//  Utils.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/4/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

struct Utils {
    static let localeUS = "en_US"

    static func convertMilitaryTime(to formatter: DateFormatter, time: String) -> String {
        var militaryTime = ""
        let charactersInMilitaryTime = 4
        if time.count >= charactersInMilitaryTime {
            militaryTime = time
        } else if time.count <= 2 {
            militaryTime = "00\(time)"
        } else {
            militaryTime = "0\(time)"
        }
        if let timeDate = formatter.date(from: militaryTime) {
            formatter.dateFormat = "HH:mm"
            let timeh = formatter.string(from: timeDate)
            return timeh
        }
        return ""
    }
    
}
