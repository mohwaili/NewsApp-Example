//
//  NewsDateFormatter.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 24/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class NewsDateFormatter {
    
    static let instance: NewsDateFormatter = .init()
    
    private let formatter: ISO8601DateFormatter
    
    private init() {
        formatter = ISO8601DateFormatter()
    }
    
    func date(from string: String) -> Date? {
        return formatter.date(from: string)
    }
    
}
