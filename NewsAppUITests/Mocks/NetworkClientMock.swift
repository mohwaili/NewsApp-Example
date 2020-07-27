//
//  NetworkClientMock.swift
//  NewsAppUITests
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

final class NetworkClientMock: NetworkClientProtocol {
    var baseURL: URL {
        URL(string: "https://google.com")!
    }
    
    func performRequest(_ request: URLRequest,
                        completion: @escaping (Result<Data, RequestError>) -> Void) -> URLSessionDataTask? {
        nil
    }
    
    func performRequest<R>(_ request: URLRequest,
                           completion: @escaping (Result<R, RequestError>) -> Void)
        -> URLSessionDataTask? where R: Decodable {
        nil
    }
    
    func downloadImage(_ request: URLRequest,
                       completion: @escaping (Result<UIImage, RequestError>) -> Void) -> URLSessionDataTask? {
        let fakeImage = UIImage(named: "fake_image", in: Bundle(for: NetworkClientMock.self), compatibleWith: nil)!
        completion(.success(fakeImage))
        return nil
    }
    
}
