//
//  Cache.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation
import RealmSwift

enum RefreshInterval: Int {
    case twentySeconds  =      20
    case oneMinute      =      60
    case twoMinutes     =     120
    case fiveMinutes    =     300
    case halfHour       =    1800   // 30 minutes
    case oneHour        =    3600   // 60 minutes
    case oneDay         =   86400   // 24 hours
    case oneWeek        =  604800   //  7 days
    case oneMonth       = 2592000   // 30 days
}

protocol Cache {
    static func objects() -> ([Any]?, Bool)
    static func objects(predicateFormat: String, _ args: Any...) -> ([Any]?, Bool)
    static func add(object: Any)
    static func delete(object: Object)
    static func clear()
}
