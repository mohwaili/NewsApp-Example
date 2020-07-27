//
//  NewsOverviewTableView.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

protocol NewsOverviewTableViewSelectionDelegate: class {
    func didSelectedNewsArticle(_ article: Article)
}

class NewsOverviewTableView: UITableView {
    
    private let viewModel: NewsOverviewTableViewViewModel
    
    weak var selectionDelegate: NewsOverviewTableViewSelectionDelegate?
    
    init(with viewModel: NewsOverviewTableViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .grouped)
        
        self.register(NewsOverviewTableViewCell.self,
                      forCellReuseIdentifier: NewsOverviewTableViewCell.reusableIdentifier)
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 100
        
        self.dataSource = self.viewModel.dataSource
        self.delegate = self.viewModel.delegate
        
        self.viewModel.dataChangedHandler = { [weak self] in
            self?.reloadData()
        }
        self.viewModel.articleSelectionHandler = { [weak self] article in
            self?.selectionDelegate?.didSelectedNewsArticle(article)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
