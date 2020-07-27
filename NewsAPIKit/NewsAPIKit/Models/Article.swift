//
//  Article.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 24/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

public struct ArticlesResponse: Decodable {
    public let status: String
    public let totalResults: Int
    public let articles: [Article]
}

public struct Source: Decodable, Equatable {
    // swiftlint:disable identifier_name
    public let id: String
    public let name: String
}

public struct Article: Decodable {
    public let source: Source?
    public let author: String?
    public let title: String?
    public let description: String?
    private let urlString: String?
    private let imageURLString: String?
    private let publishedDateString: String?
    public let content: String?
    
    public var url: URL? {
        URL(string: urlString ?? "")
    }
    
    public var imageURL: URL? {
        URL(string: imageURLString ?? "")
    }
    
    public var publishedDate: Date? {
        NewsDateFormatter.instance.date(from: publishedDateString ?? "")
    }
    
    public enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case urlString = "url"
        case imageURLString = "urlToImage"
        case publishedDateString = "publishedAt"
        case content
    }
    
    public init(source: Source?,
         author: String?,
         title: String?,
         description: String?,
         urlString: String?,
         imageURLString: String?,
         publishedDateString: String?,
         content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.urlString = urlString
        self.imageURLString = imageURLString
        self.publishedDateString = publishedDateString
        self.content = content
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.source = try? container.decode(Source.self, forKey: .source)
        self.author = try? container.decode(String.self, forKey: .author)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.urlString = try? container.decode(String.self, forKey: .urlString)
        self.imageURLString = try? container.decode(String.self, forKey: .imageURLString)
        self.publishedDateString = try? container.decode(String.self, forKey: .publishedDateString)
        self.content = try? container.decode(String.self, forKey: .content)
    }
    
}

extension Article: Equatable {
    
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.source == rhs.source &&
            lhs.author == rhs.author &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.urlString == rhs.urlString &&
            lhs.imageURLString == rhs.imageURLString &&
            lhs.publishedDateString == rhs.publishedDateString &&
            lhs.content == rhs.content
    }
    
}
