//
//  ListEvents.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

protocol ListEvents {
    func execute(completion: @escaping EventsClosure)
}
