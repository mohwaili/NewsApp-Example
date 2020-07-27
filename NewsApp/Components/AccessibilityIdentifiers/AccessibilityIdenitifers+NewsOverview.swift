//
//  AccessibilityIdenitifers+NewsOverview.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

extension AccessibilityIdenitifers {
    
    struct NewsOverview {
        static let rootViewId = "\(NewsOverview.self).rootViewId"
        static let searchInputField = "\(NewsOverview.self).searchInputField"
        static let searchButton = "\(NewsOverview.self).searchButton"
        static let categories = "\(NewsOverview.self).categories"
        static let articlesTableView = "\(NewsOverview.self).articlesTableView"
        
        static func categoryItem(at index: Int) -> String {
            return "\(NewsOverview.self).categoryItem\(index)"
        }
        
        static func articleItem(at index: Int, in section: Int) -> String {
            return "\(NewsOverview.self).articleItem\(section)\(index)"
        }
        
    }
    
}
