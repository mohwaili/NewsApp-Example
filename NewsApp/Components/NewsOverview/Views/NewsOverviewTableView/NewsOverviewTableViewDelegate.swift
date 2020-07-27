//
//  NewsOverviewTableViewDelegate.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class NewsOverviewTableViewDelegate: NSObject, UITableViewDelegate {
    
    var indexPathSelectedClosure: ((IndexPath) -> Void)?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        indexPathSelectedClosure?(indexPath)
    }
    
}
