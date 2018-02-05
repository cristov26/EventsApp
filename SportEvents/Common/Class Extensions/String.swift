//
//  String.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/3/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import Foundation

extension String {
    
    var utf8Data: Data? {
        return data(using: .utf8)
    }
    
    /**
     Get the localized string with empty comment, first will search the key in Default.strings file and
     if the key is not found, it will search in Localized.string file.
     
     - returns: A localized string, if not found returns an empty string
     */
    func localized() -> String {
        return localized(withComment: "")
    }
    
    /**
     Get the localized string, first will search the key in Default.strings file and
     if the key is not found, it will search in Localized.string file.
     
     - parameter withComment: comment
     - returns: A localized string, if not found returns an empty string
     */
    func localized(withComment: String) -> String {
        let localized = Bundle.main.localizedString(forKey: self, value: withComment, table: nil)
        return localized
    }
}
