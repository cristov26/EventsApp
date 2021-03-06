//
//  EventsWebService.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

protocol EventsWebService {
    func retrieveEvents(completion: @escaping (ServiceResponse) -> Void)
}
