//
//  NetworkClient.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 23/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

public enum RequestError: Error {
    case invalidRequest
    case invalidResponse
    case noData
    case requestError
    case serverError
}

public protocol NetworkClientProtocol {
    var baseURL: URL { get }
    
    init()

    @discardableResult
    func performRequest(_ request: URLRequest,
                        completion: @escaping (Result<Data, RequestError>) -> Void) -> URLSessionDataTask?
    
    @discardableResult
    func performRequest<R: Decodable>(_ request: URLRequest,
                                      completion: @escaping (Result<R, RequestError>) -> Void) -> URLSessionDataTask?
    
    @discardableResult
    func downloadImage(_ request: URLRequest,
                       completion: @escaping (Result<UIImage, RequestError>) -> Void) -> URLSessionDataTask?
    
}

public class NetworkClient: NetworkClientProtocol {
    
    private struct Constants {
        // swiftlint:disable force_cast
        static let apiKey = Bundle.main.object(forInfoDictionaryKey: "newsApiKey") as! String
    }
    
    public var baseURL: URL {
        // swiftlint:disable force_cast
        let urlString = Bundle.main.object(forInfoDictionaryKey: "newsApiBaseUrl") as! String
        return URL(string: urlString)!
    }
    
    public required init() {
    }
    
    public func performRequest(_ request: URLRequest,
                               completion: @escaping (Result<Data, RequestError>) -> Void) -> URLSessionDataTask? {
        var finalRequest = request
        finalRequest.addValue(Constants.apiKey, forHTTPHeaderField: "x-api-key")
        
        let task = URLSession.shared.dataTask(with: finalRequest) { (data, response, error) in
            guard error == nil else {
                return completion(.failure(.serverError))
            }
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.invalidResponse))
            }
            guard 200..<300 ~= response.statusCode else {
                return completion(.failure(.requestError))
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            completion(.success(data))
        }
        task.resume()
        return task
    }
    
    public func performRequest<R>(_ request: URLRequest,
                                  completion: @escaping (Result<R, RequestError>) -> Void)
        -> URLSessionDataTask? where R: Decodable {
        return performRequest(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let object = try? JSONDecoder().decode(R.self, from: data) else {
                        return completion(.failure(.invalidResponse))
                    }
                    completion(.success(object))
                }
            }
        }
    }
    
    public func downloadImage(_ request: URLRequest,
                              completion: @escaping (Result<UIImage, RequestError>) -> Void)
        -> URLSessionDataTask? {
        return performRequest(request) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    return completion(.failure(.noData))
                }
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }
        }
    }
    
}
