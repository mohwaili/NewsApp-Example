//
//  NewsRequestBuilderTests.swift
//  NewsAPIKitTests
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import XCTest
@testable import NewsAPIKit

class NewsRequestBuilderTests: XCTestCase {

    func testNewsRequestBuilder_buildingCorrectScheme() {
        // Given
        let builder = NewsRequestBuilder(baseURL: "https://google.com")
        
        // When
        let request = builder?.build()
        
        // Then
        let components = URLComponents(string: request?.url?.absoluteString ?? "")
        XCTAssertEqual(components?.scheme, "https")
    }
    
    func testNewsRequestBuilder_buildingCorrectHost() {
        // Given
        let builder = NewsRequestBuilder(baseURL: "https://google.com")
        
        // When
        let request = builder?.build()
        
        // Then
        let components = URLComponents(string: request?.url?.absoluteString ?? "")
        XCTAssertEqual(components?.host, "google.com")
    }
    
    func testNewsRequestBuilder_buildingCorrectHTTPMethod() {
        // Given
        let builder = NewsRequestBuilder(baseURL: "https://google.com")
        
        // When
        let request = builder?.setHTTPMethod(.post).build()
        
        // Then
        XCTAssertEqual(request?.httpMethod, "POST")
    }
    
    func testNewsRequestBuilder_ignoringWrongPath() {
        // Given
        let builder = NewsRequestBuilder(baseURL: "https://google.com")
        
        // When
        let request = builder?.setEndpoint("users").build()
        
        // Then
        let components = URLComponents(string: request?.url?.absoluteString ?? "")
        XCTAssertEqual(components?.path, "")
    }
    
    func testNewsRequestBuilder_buildingCorrectPath() {
        // Given
        let builder = NewsRequestBuilder(baseURL: "https://google.com")
        
        // When
        let request = builder?.setEndpoint("/users").build()
        
        // Then
        let components = URLComponents(string: request?.url?.absoluteString ?? "")
        XCTAssertEqual(components?.path, "/users")
    }
    
    func testNewsRequestBuilder_buildingCorrectParameters() {
        // Given
        let builder = NewsRequestBuilder(baseURL: "https://google.com")
        
        // When
        let request = builder?.setParameters([QueryParameter(name: "q", value: "test")]).build()
        
        // Then
        let components = URLComponents(string: request?.url?.absoluteString ?? "")
        let queryParam = components?.queryItems?.first
        XCTAssertEqual(queryParam?.name, "q")
        XCTAssertEqual(queryParam?.value, "test")
    }
    
}
