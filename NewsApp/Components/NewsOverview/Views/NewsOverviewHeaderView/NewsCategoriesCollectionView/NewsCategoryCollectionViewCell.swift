//
//  NewsCategoryCollectionViewCell.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit
import NewsUIKit

class NewsCategoryCollectionViewCell: UICollectionViewCell {
    
    private lazy var categoryTitleLabel: UILabel = createCategoryTitleLabel()
    var category: NewsHeadlineCategory?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        clipsToBounds = true
        layer.cornerRadius = 4
        layer.borderColor = NewsColor.Primary.Borders.mainColor.cgColor
        layer.borderWidth = 0.3
        
        addSubview(categoryTitleLabel)
        NSLayoutConstraint.activate([
            categoryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoryTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            categoryTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: NewsHeadlineCategory, at indexPath: IndexPath, isSelected: Bool) {
        categoryTitleLabel.accessibilityIdentifier = AccessibilityIdenitifers
            .NewsOverview
            .categoryItem(at: indexPath.item)
        self.category = category
        categoryTitleLabel.text = category.rawValue
        setSelected(isSelected)
    }
    
    func setSelected(_ selected: Bool) {
        backgroundColor = selected ? NewsColor.Primary.greenLight : .white
    }
    
}

// MARK: - UI
extension NewsCategoryCollectionViewCell {
 
    private func createCategoryTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.textColor = .black
        return label
    }
    
}
