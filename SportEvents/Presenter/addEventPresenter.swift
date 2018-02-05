//
//  addEventPresenter.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/4/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

final class AddEventPresenter {
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Format.HHmm
        dateFormatter.locale = Locale(identifier: Utils.localeUS)
        return dateFormatter
    }()
    let lastId: Int!
    
    init(lastEventId: Int) {
        lastId = lastEventId
    }
    func saveEvent(name: String, description: String, initialDate: String, endDate: String?, forum: String?, location:String?, isPublic: Bool) -> (Bool, String){
        if name.isEmpty || description.isEmpty || initialDate.isEmpty {
            return (false, "MISSING_ARGUMENTS_ERROR".localized())
        }
        var validDate = false
        var initialDateFormatted = ""
        (validDate, initialDateFormatted) = validateDate(date: initialDate)
        if !validDate {
            return (validDate, initialDateFormatted)
        }
        var finalDateFormatted = ""
        if let finalDate = endDate, !finalDate.isEmpty {
            validDate = false
            (validDate, finalDateFormatted) = validateDate(date: finalDate)
            if !validDate {
                return (validDate, finalDateFormatted)
            }
        }
        let finalDateString = finalDateFormatted.isEmpty ?  nil : finalDateFormatted
        var participantsInt: Int? = nil
        if let participants = forum {
            participantsInt = Int(participants)
        }
        let event = rawEvent(eventId: lastId+1, eventName: name, eventDescription: description, initialDate: initialDateFormatted, endDate: finalDateString, forum: participantsInt, current: 0, location: location, isPublic: isPublic)
        EventsCacheImpl.add(object: event)
        return (true, "")
    }
    
    func validateDate(date:String) -> (Bool, String){
        if let DateFormatted = convertInputDateIntoDatabaseDate(date: date) {
            dateFormatter.dateFormat = Format.yyyymmdd_HHmm
            let today = dateFormatter.string(from: Date())
            if let date = dateFormatter.date(from: DateFormatted), let todayDate = dateFormatter.date(from: today), todayDate >= date {
                return (false, "OLD_DATE_ERROR".localized())
            } else {
                return (true, DateFormatted)
            }
        } else {
            return (false, "DATE_FORMATTER_ERROR".localized())
        }
    }
    
    func convertInputDateIntoDatabaseDate(date: String) -> String? {
        dateFormatter.dateFormat = Format.yyyy_mm_dd_hh_mm
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = Format.yyyymmdd_HHmm
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
