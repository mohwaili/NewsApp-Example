//
//  NewsOverviewTableViewViewModel.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import NewsAPIKit

class NewsOverviewTableViewViewModel {
    
    enum Sections: Int, CaseIterable {
        case headlines
        case allArticles
        
        var title: String {
            switch self {
            case .headlines:
                return Localized.headlinesTitle
            case .allArticles:
                return Localized.articlesTitle
            }
        }
    }
    
    let dataSource: NewsOverviewTableViewDataSource
    // swiftlint:disable weak_delegate
    let delegate: NewsOverviewTableViewDelegate
    
    typealias Data = AggregatedArticles
    private var data: Data? {
        didSet {
            guard let data = data else { return }
            dataSource.updateData(data)
            dataChangedHandler?()
        }
    }
    var dataChangedHandler: (() -> Void)?
    var articleSelectionHandler: ((Article) -> Void)?
    
    init(with data: Data?) {
        self.data = data
        dataSource = .init(with: data)
        delegate = .init()
        delegate.indexPathSelectedClosure = { [weak self] indexPath in
            guard
                let self = self,
                let article = self.article(for: indexPath) else { return }
            self.articleSelectionHandler?(article)
        }
    }
    
    func updateData(data: Data) {
        self.data = data
    }
    
    private func article(for indexPath: IndexPath) -> Article? {
        guard let data = data else {
            return nil
        }
        switch indexPath.section {
        case Sections.headlines.rawValue:
            return data.headlines[indexPath.row]
        case Sections.allArticles.rawValue:
            return data.articles[indexPath.row]
        default:
            return nil
        }
    }
    
}
