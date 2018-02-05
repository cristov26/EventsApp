//
//  EventsRepositoryImpl.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

class EventsRepositoryImpl: EventsRepository {
    
    let eventsWebService = EventsWebServiceImpl()
    
    internal var lastSyncDate: Date? {
        get {
            return nil
        }
    }
    
    func listEvents(completion: @escaping EventsClosure) {
        var events: [Any]?
        var hasToUpdate: Bool
        (events, hasToUpdate) = EventsCacheImpl.objects(predicateFormat: "")
        if hasToUpdate {
            eventsWebService.retrieveEvents(completion: {[unowned self] (response) in
                self.handleWebServiceResponse(response: response, completion: completion)
            })
        } else {
            if let eventsResult = events as? [Event] {
                completion(.success(eventsResult))
            } else {
                completion(.failure)
            }
        }
    }
    
    func cancelAllRequest() {
        // TODO: Implementation missing
    }
}


private extension EventsRepositoryImpl {
    func handleWebServiceResponse(response: ServiceResponse, completion: @escaping EventsClosure) {
        var result = [Event]()
        switch response {
        case .success(let events):
            for event in events {
                EventsCacheImpl.add(object: event as! Event)
                result.append(event as! Event)
            }
            if result.count > 0 {
                completion(.success(result))
            } else {
                completion(.failure)
            }
        case .notConnectedToInternet:
            completion(.notConnectedToInternet)
        case .failure:
            completion(.failure)
        }
    }
}
