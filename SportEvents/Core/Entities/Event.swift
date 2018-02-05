//
//  Event.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/2/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

protocol Event {
    
    var eventId: Int { get }
    var eventName: String { get }
    var eventDescription: String { get }
    var initialDate: String { get }
    var endDate: String? { get }
    var forum: Int? { get }
    var current: Int? { get }
    var location: String? { get }
    var isPublic: Bool? { get }
    
}

struct rawEvent: Event{
    
    let eventId: Int
    let eventName: String
    let eventDescription: String
    let initialDate: String
    let endDate: String?
    let forum: Int?
    let current: Int?
    let location: String?
    let isPublic: Bool?
    
}
