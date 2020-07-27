//
//  File.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailHeaderView: UIView {
    
    private lazy var imageView: UIImageView = createImageView()
    
    private let viewModel: NewsDetailHeaderViewModel
    
    init(with viewModel: NewsDetailHeaderViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        viewModel.downloadArticleImage { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(imageView)
        setupConstraints()
    }
    
}

// MARK: - UI
extension NewsDetailHeaderView {
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
}

// MARK: - Constraints
extension NewsDetailHeaderView {
    
    private func setupConstraints() {
        // ImageView constraints
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
    }
    
}
