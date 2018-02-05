//
//  EventDetailPresenter.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/4/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

final class EventDetailPresenter {
    
    let event: Event
    let localeUS = "en_US"
    let dateDelimiter = "/"

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Format.HHmm
        dateFormatter.locale = Locale(identifier: localeUS)
        return dateFormatter
    }()
    
    init(event: Event) {
        self.event = event
    }

    func getTime(from eventDate: String) -> String {
        return eventDate.components(separatedBy: dateDelimiter)[1]
    }

    func getFormattedTime(by date: String) -> String {
        let time = getTime(from: date)
        dateFormatter.dateFormat = Format.HHmm
        let formattedTime = Utils.convertMilitaryTime(to: dateFormatter, time: time)
        return formattedTime
    }
}
