//
//  RealmEvent.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEvent: Object {
    
    @objc dynamic var r_eventId: Int = 0
    @objc dynamic var r_eventName: String = ""
    @objc dynamic var r_eventDescription: String = ""
    @objc dynamic var r_initialDate: String = ""
    @objc dynamic var r_endDate: String?
    let r_forum = RealmOptional<Int>()
    let r_current = RealmOptional<Int>()
    @objc dynamic var r_location: String?
    let r_isPublic = RealmOptional<Bool>()
    @objc dynamic var r_timestamp: NSDate?
    override static func primaryKey() -> String? {
        return "r_eventId"
    }
}

extension RealmEvent: Event {
    
    var eventId: Int { return r_eventId }
    var eventName: String { return r_eventName }
    var eventDescription: String { return r_eventDescription }
    var initialDate: String { return r_initialDate }
    var endDate: String? { return r_endDate }
    var forum: Int? { return r_forum.value }
    var current: Int? { return r_current.value }
    var location: String? { return r_location }
    var isPublic: Bool? { return r_isPublic.value }
    var timestamp: NSDate { return r_timestamp! }

}
