//
//  NewsOverviewTableViewCellViewModel.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

class NewsOverviewTableViewCellViewModel {
    
    let article: Article
    private let client: NetworkClientProtocol
    
    private let placeholderImage: UIImage = Assets.News.iconNewsPlaceholder.image
    private var task: URLSessionDataTask?
    var imageClosure: ((UIImage) -> Void)?
    
    init(with article: Article, client: NetworkClientProtocol = NetworkClient()) {
        self.client = client
        self.article = article
    }
    
    func fetchImage() {
        guard let imageURL = article.imageURL else {
            return imageClosure?(placeholderImage) ?? { }()
        }
        let request = URLRequest(url: imageURL)
        client.downloadImage(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.imageClosure?(self.placeholderImage)
            case .success(let image):
                self.imageClosure?(image)
            }
        }
    }
    
    func cancelFetchImage() {
        task?.cancel()
    }
    
}
