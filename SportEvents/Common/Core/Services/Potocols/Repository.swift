//
//  Repository.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

enum SaveStatus {
    case success
    case failure
}

protocol Repository {
    func cancelAllRequest()
}
