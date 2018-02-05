//
//  UseCaseImpl.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation


class UseCaseImpl {
    let repository: Repository
    let service: BaseService
    
    required init(repository: Repository, service: BaseService) {
        self.repository = repository
        self.service = service
    }
}
