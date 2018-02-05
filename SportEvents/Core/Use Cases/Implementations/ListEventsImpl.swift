//
//  ListEventsImpl.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

class ListEventsImpl: UseCaseImpl, ListEvents {
    func execute(completion: @escaping EventsClosure) {
        (repository as! EventsRepositoryImpl).listEvents(completion: { (response) in
            completion(response)
        })
    }
}
