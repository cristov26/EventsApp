//
//  EventsUseCaseLocator.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation
protocol EventsUseCaseLocatorProtocol {
    func getUseCase<T>(ofType type: T.Type) -> T?
}

class EventsUseCaseLocator: EventsUseCaseLocatorProtocol {
    
    static let defaultLocator = EventsUseCaseLocator(repository: EventsRepositoryImpl(),
                                                     service: EventsWebServiceImpl())
    
    fileprivate let service: BaseService
    fileprivate let repository: Repository
    
    init(repository: Repository, service: BaseService) {
        self.repository = repository
        self.service = service
    }
    
    func getUseCase<T>(ofType type: T.Type) -> T? {
        switch String(describing: type) {
        case String(describing: ListEvents.self):
            return buildUseCase(type: ListEventsImpl.self)
        default:
            return nil
        }
    }
}


private extension EventsUseCaseLocator {
    func buildUseCase<U: UseCaseImpl, R>(type: U.Type) -> R? {
        return U(repository: repository, service: service) as? R
    }
}
