//
//  EventsWebService.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

class EventsWebServiceImpl: BaseService, EventsWebService {
    static let endPoint = AppConstants.endPoint

    func retrieveEvents(completion: @escaping (ServiceResponse) -> Void) {
        super.callEndpoint(endPoint: type(of: self).endPoint, completion: completion)
    }
    
    override func parse(response: AnyObject) -> [AnyObject]? {
        let events = EventsWebServiceImpl.parse(data: response) as [AnyObject]?
        return events
    }
}

private extension EventsWebServiceImpl {
    static func parse(data: AnyObject) -> [Event]? {
        if data is NSDictionary {
            guard let feed = data[EventParseConstants.events] as? [NSDictionary]
            else {
                return nil
            }
            return feed.enumerated().map(parseEvent).filter {$0 != nil}.map { $0! }
        }
        return nil
    }
    
    static func parseEvent(rank: Int, data: NSDictionary) -> Event? {
        guard let eventId = data.value(forKeyPath: EventParseConstants.eventId) as? Int,
        let eventName = data.value(forKeyPath: EventParseConstants.eventName) as? String,
        let eventDescription = data.value(forKeyPath: EventParseConstants.eventDescription) as? String,
        let initialDate = data.value(forKeyPath: EventParseConstants.initialDate) as? String
            else {
                return nil
        }
        
        return rawEvent(eventId: eventId,
                        eventName: eventName,
                        eventDescription: eventDescription,
                        initialDate: initialDate,
                        endDate: (data.value(forKeyPath: EventParseConstants.endDate) as? String),
                        forum: (data.value(forKeyPath: EventParseConstants.forum) as? Int),
                        current: (data.value(forKeyPath: EventParseConstants.current) as? Int),
                        location: (data.value(forKeyPath: EventParseConstants.location) as? String),
                        isPublic: (data.value(forKeyPath: EventParseConstants.isPublic) as? Bool))
    }
}
