//
//  SearchHistory.swift
//  Smashtag
//
//  Created by Murty Gudipati on 3/15/15.
//  Copyright (c) 2015 Murty Gudipati. All rights reserved.
//

import Foundation

private let defaults = NSUserDefaults.standardUserDefaults()

public class SearchHistory
{
    class var items: [String] {
        get { return defaults.objectForKey(SearchKey.History) as? [String] ?? [] }
        set { defaults.setObject(newValue.map { $0.lowercaseString }, forKey: SearchKey.History) }
    }
    
    class func distinct<T: Equatable>(source: [T]) -> [T] {
        var unique = [T]()
        for item in source {
            if !contains(unique, item) {
                unique.append(item)
            }
        }
        return unique
    }
    
    struct SearchKey {
        static let History = "TwitterSearch.History"
    }
}