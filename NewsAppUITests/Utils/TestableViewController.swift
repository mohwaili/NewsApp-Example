//
//  TestableViewController.swift
//  NewsAppUITests
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class Page {
    
    required init() {
        
    }

    static func on<T: Page>(_ type: T.Type) -> T {
        let page = T()
        page.verify()
        return page
    }

    func verify() {
        fatalError("Override \(#function) function in a subclass!")
    }
}
