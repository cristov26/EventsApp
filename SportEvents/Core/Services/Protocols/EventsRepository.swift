//
//  Repository.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation
enum EventServiceResponse {
    case success([Event]?)
    case failure
    case notConnectedToInternet
}

typealias EventsClosure = (EventServiceResponse) -> Void

protocol EventsRepository: Repository {
    func listEvents(completion: @escaping EventsClosure)
}
