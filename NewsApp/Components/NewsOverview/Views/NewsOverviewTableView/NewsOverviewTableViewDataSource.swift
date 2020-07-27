//
//  NewsOverviewTableViewDataSource.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

class NewsOverviewTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var data: NewsOverviewTableViewViewModel.Data?
    
    init(with data: NewsOverviewTableViewViewModel.Data?) {
        self.data = data
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard data != nil else {
            return 0
        }
        return NewsOverviewTableViewViewModel.Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data else {
            return 0
        }
        switch section {
        case NewsOverviewTableViewViewModel.Sections.headlines.rawValue:
            return data.headlines.count
        case NewsOverviewTableViewViewModel.Sections.allArticles.rawValue:
            return data.articles.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: NewsOverviewTableViewCell.reusableIdentifier, for: indexPath)
            as? NewsOverviewTableViewCell else {
            fatalError("Wrong configuration")
        }
        guard let article = article(for: indexPath) else {
            return cell
        }
        cell.configure(with: .init(with: article), indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard data != nil else {
            return nil
        }
        return NewsOverviewTableViewViewModel.Sections(rawValue: section)?.title
    }
    
    func updateData(_ data: NewsOverviewTableViewViewModel.Data) {
        self.data = data
    }
    
    private func article(for indexPath: IndexPath) -> Article? {
        guard let data = data else {
            return nil
        }
        switch indexPath.section {
        case NewsOverviewTableViewViewModel.Sections.headlines.rawValue:
            return data.headlines[indexPath.row]
        case NewsOverviewTableViewViewModel.Sections.allArticles.rawValue:
            return data.articles[indexPath.row]
        default:
            return nil
        }
    }
    
}
