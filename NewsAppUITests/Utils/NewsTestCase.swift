//
//  NewsTestCase.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import XCTest
import EarlGrey

class NewsTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        setupEarlGrey()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupEarlGrey() {
        GREYConfiguration.sharedInstance().setValue(false, forConfigKey: kGREYConfigKeyAnalyticsEnabled)
        GREYConfiguration.sharedInstance().setValue(10.0, forConfigKey: kGREYConfigKeyInteractionTimeoutDuration)
        GREYTestHelper.enableFastAnimation()
    }

}
