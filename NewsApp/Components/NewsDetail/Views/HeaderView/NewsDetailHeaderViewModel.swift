//
//  NewsDetailHeaderViewModel.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

class NewsDetailHeaderViewModel {
    
    private let article: Article
    private let client: NetworkClientProtocol
    private var task: URLSessionDataTask?
    
    init(with article: Article, client: NetworkClientProtocol = NetworkClient()) {
        self.article = article
        self.client = client
    }
    
    func downloadArticleImage(completion: @escaping (UIImage) -> Void) {
        let placeholderImage = Assets.News.iconNewsPlaceholder.image
        guard let imageUrl = article.imageURL else {
            return completion(placeholderImage)
        }
        let request = URLRequest(url: imageUrl)
        task = client.downloadImage(request) { result in
            switch result {
            case .failure:
                completion(placeholderImage)
            case .success(let image):
                completion(image)
            }
        }
    }
    
    func cancelImageDownload() {
        task?.cancel()
    }
    
}
