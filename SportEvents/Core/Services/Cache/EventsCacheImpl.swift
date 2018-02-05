//
//  EventsCacheImpl.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation
import RealmSwift

struct EventsCacheImpl: Cache {
    
    static func objects() -> ([Any]?, Bool) {
        return objects(predicateFormat: "", "")
    }
    
    static func objects(predicateFormat: String, _ args: Any...) -> ([Any]?, Bool) {
        guard let realm = try? Realm() else {
            return (nil, true)
        }
        
        var realmObjects: [Any]?
        if predicateFormat.characters.count > 0 {
            realmObjects = Array(realm.objects(RealmEvent.self).filter(predicateFormat, args))
        }
        else {
            realmObjects = Array(realm.objects(RealmEvent.self))
        }
        
        return getModelObjects(realmObjects: realmObjects)
    }
    
    static func add(object: Any) {
        guard let realm = try? Realm() else {
            return
        }
        
        try! realm.write {
            
            let realmObj = RealmEvent()
            let modelObj = object as! Event
            realmObj.r_eventId = modelObj.eventId
            realmObj.r_eventName = modelObj.eventName
            realmObj.r_eventDescription = modelObj.eventDescription
            realmObj.r_initialDate = modelObj.initialDate
            realmObj.r_endDate = modelObj.endDate
            realmObj.r_forum.value = modelObj.forum
            realmObj.r_current.value = modelObj.current
            realmObj.r_location = modelObj.location
            realmObj.r_isPublic.value = modelObj.isPublic
            realmObj.r_timestamp = NSDate()
            realm.add(realmObj, update: true)
            
            
        }
    }
    
    static func delete(object: Object) {
        guard let realm = try? Realm() else {
            return
        }
        
        try! realm.write {
            realm.delete(object)
        }
    }
    static func clear() {
        guard let realm = try? Realm() else {
            return
        }
        try! realm.write {
            realm.deleteAll()
        }
    }
}


private extension EventsCacheImpl {
    
    
    
    static func checkForExpiration(date: NSDate, expirationInterval interval: RefreshInterval, currentValue: Bool) -> Bool {
        return currentValue ? currentValue : (date.addingTimeInterval(TimeInterval(interval.rawValue)) as Date) <= Date()
    }
    
    static func getModelObjects(realmObjects: [Any]?) -> ([Any]?, Bool) {
        if realmObjects == nil || realmObjects?.count == 0 {
            return (nil, true)
        }
        
        var modelObjects = [Any]()
        var hasToUpdate = false
        
        for item in realmObjects! {
            let realmObj = item as! RealmEvent
            var refreshInterval: RefreshInterval
            
            // TODO: Set this based on what Product Owner says
            refreshInterval = .halfHour
            
            
            hasToUpdate = checkForExpiration(date: realmObj.timestamp, expirationInterval: refreshInterval, currentValue: hasToUpdate)
            
            
            let event = rawEvent(eventId: realmObj.eventId,
                                 eventName: realmObj.eventName,
                                 eventDescription: realmObj.eventDescription,
                                 initialDate: realmObj.initialDate,
                                 endDate: realmObj.endDate,
                                 forum: realmObj.forum,
                                 current: realmObj.current,
                                 location: realmObj.location,
                                 isPublic: realmObj.isPublic)
            modelObjects.append(event)
            
            
        }
        
        return modelObjects.count > 0 ? (modelObjects, hasToUpdate) : (nil, true)
    }
    
}
