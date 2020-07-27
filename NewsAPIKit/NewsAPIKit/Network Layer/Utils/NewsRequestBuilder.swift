//
//  NewsRequestBuilder.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 24/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

public struct QueryParameter {
    public let name: String
    public let value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

enum NewsEndpoint: String {
    case everything = "/v2/everything"
    case headlines = "/v2/top-headlines"
    case sources = "/v2/sources"
}

class NewsRequestBuilder {
    
    private var httpMethod: HTTPMethod = .get
    private var components: URLComponents
    // The + sign needs to be encoded manually
    // acknowledged by Apple...
    private let replacableEncodingCharacters: [ReplacableEncodingCharacter] = [
        .init(character: "+", replacement: "%2B")
    ]
    
    private struct ReplacableEncodingCharacter {
        let character: String
        let replacement: String
    }
    
    init?(baseURL: String) {
        guard
            let urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        self.components = urlComponents
    }
    
    /**
       Sets the http method for the request url

       - returns:
       The modified NewsRequestBuilder
       - parameters:
          - method:the http method for the request
       */
    func setHTTPMethod(_ method: HTTPMethod) -> Self {
        self.httpMethod = method
        return self
    }
    
    /**
     Sets the news endpoint for the request url
     
     - returns:
     The modified NewsRequestBuilder
     - parameters:
        - endpoint:the enpoint for the request
     
     Be sure to provide a valid endpoint like the following: /users
     
     */
    func setEndpoint(_ endpoint: String) -> Self {
        components.path = endpoint
        return self
    }
    
    /**
    Sets the query items for the request url
    
    - returns:
    The modified NewsRequestBuilder
    - parameters:
       - parameters:the desired query parameters for the url request

    */
    func setParameters(_ parameters: [QueryParameter]) -> Self {
        let queryItems = parameters.map { parameter in
            URLQueryItem(name: parameter.name, value: parameter.value)
        }
        components.queryItems = queryItems
        replacableEncodingCharacters.forEach { replacableEncodingCharacter in
            components.percentEncodedQuery = components
                .percentEncodedQuery?
                .replacingOccurrences(of: replacableEncodingCharacter.character,
                                      with: replacableEncodingCharacter.replacement)
        }
        return self
    }
    
    /**
       Build a url request with the provided configuration
       
       - returns:
       The modified NewsRequestBuilder
       - parameters:
          - parameters:the desired query parameters for the url request

       */
    func build() -> URLRequest? {
        guard let url = components.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
}
