//
//  EventsPresenter.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/4/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import UIKit

struct Format {
    static let HHmm = "HHmm"
    static let yyyymmdd = "yyyyMMdd"
    static let dd_mm_yyyy = "dd/MM/yyyy"
    static let yyyymmdd_HHmm = "yyyyMMdd/HHmm"
    static let yyyy_mm_dd_hh_mm = "yyyy/MM/dd-HH:mm"
}

final class EventsPresenter {

    
    fileprivate let locator: EventsUseCaseLocatorProtocol
    let dateDelimiter = "/"
    var events: [Event] = [Event]()
    let localeUS = "en_US"

    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
    }

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Format.HHmm
        dateFormatter.locale = Locale(identifier: localeUS)
        return dateFormatter
    }()
    
    var emptyDataMessage: String {
        get {
            let messageString = AppConstants.noEventsMessage
            return messageString
        }
    }
    
    init(locator: EventsUseCaseLocatorProtocol) {
        self.locator = locator
    }
    
    func loadEvents(completion: @escaping EventsClosure) {
        guard let useCase = self.locator.getUseCase(ofType: ListEvents.self) else {
            completion(.failure)
            return
        }
        useCase.execute(completion: { [weak self] (response) in
            guard let strongSelf = self else { return }
            
            switch response {
                
            case .success(let result):
                if let events = result {
                    strongSelf.events = events
                    completion(.success(events))
                    return
                }
                completion(.failure)
            case .failure:
                completion(.failure)
            case .notConnectedToInternet:
                completion(.notConnectedToInternet)
            }
        })
    }
    
    func clearEvents() {
        EventsCacheImpl.clear()
    }
}

//MARK: -
extension EventsPresenter {
    func retrieveDates() -> [String]{
        var datesArray = [String]()
        for event in events {
            let date = getDate(from: event.initialDate)
            if !datesArray.contains(date) {
                datesArray.append(date)
            }
        }
        return datesArray
    }
    
    func cuantityOfRowsPer(date: String) -> Int {
        let eventsInDate = events.filter({ return getDate(from: $0.initialDate) == date})
        return eventsInDate.count
    }
    
    func getDate(from eventDate: String) -> String {
        return eventDate.components(separatedBy: dateDelimiter)[0]
    }
    
    func getTime(from eventDate: String) -> String {
        return eventDate.components(separatedBy: dateDelimiter)[1]
    }
    
    func getEventFor(indexPath: IndexPath) -> Event? {
        let dates = retrieveDates()
        let date = dates[indexPath.section]
        let eventsWithDate = events.filter({ return getDate(from: $0.initialDate) == date})
        if indexPath.row < eventsWithDate.count {
            return eventsWithDate[indexPath.row]
        } else {
            return nil
        }
    }
    
    func getTimeFrame(For event:Event) -> String{
        let firstTime = getTime(from: event.initialDate)
        dateFormatter.dateFormat = Format.HHmm
        var timeFrame = Utils.convertMilitaryTime(to: dateFormatter, time: firstTime)
        if let endDate = event.endDate {
            if timeFrame.isEmpty {
                return timeFrame
            }
            dateFormatter.dateFormat = Format.HHmm
            let secondTime = Utils.convertMilitaryTime(to: dateFormatter, time: getTime(from: endDate))
            timeFrame += " - \(secondTime)"
        }
        return timeFrame
    }
    
    func getParticipantsText(For event:Event) -> String? {
        var participantsText = ""
        if let comingParticipants = event.current {
            participantsText = "\(comingParticipants)"
        }
        if let totalParticipants = event.forum {
            if !participantsText.isEmpty {
                participantsText += "/" + "\(totalParticipants)"
            } else {
                participantsText = "\(totalParticipants)"
            }
        }
        if participantsText.isEmpty {
            return nil
        }
        return participantsText
    }
    
    func getTitleFor(section: Int) -> String {
        dateFormatter.dateFormat = Format.yyyymmdd
        let dates = retrieveDates()
        var dateString = getDate(from: dates[section])
        let todayDateString = dateFormatter.string(from: Date())
        if dateString == todayDateString {
            return "TODAY".localized()
        }
        if let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: noon) {
            let tomorrowString = dateFormatter.string(from: tomorrowDate)
            if tomorrowString == dateString {
                return "TOMORROW".localized()
            }
        }
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = Format.dd_mm_yyyy
            dateString = dateFormatter.string(from: date)
        }
        return dateString
    }
    
    func getEventForId(eventId: String) -> Event? {
        if let event = events.filter({return "\($0.eventId)" == eventId}).first {
            return event
        } else {
            return nil
        }
    }
    
    func getLastEventId() -> Int {
        let lastEvent = events.sorted(by: { $0.eventId > $1.eventId })
        if let eventId = lastEvent.first?.eventId {
            return eventId
        }
        return 0
    }
}
