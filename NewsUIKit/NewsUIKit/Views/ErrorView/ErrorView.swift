//
//  ErrorView.swift
//  NewsUIKit
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

public protocol ErrorViewDelegate: class {
    func errorViewDidTapRetry()
}

public class ErrorView: UIView {
    
    private lazy var errorImageView: UIImageView = createErrorImageView()
    private lazy var retryButton: UIButton = createRetryButton()
    
    private let viewModel: ErrorViewViewModel
    
    public weak var delegate: ErrorViewDelegate?
    
    public init(with viewModel: ErrorViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(errorImageView)
        addSubview(retryButton)
        
        // error image view constraints
        NSLayoutConstraint.activate([
            errorImageView.widthAnchor.constraint(equalToConstant: 200),
            errorImageView.heightAnchor.constraint(equalToConstant: 200),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // retry button constraints
        NSLayoutConstraint.activate([
            retryButton.widthAnchor.constraint(equalToConstant: 150),
            retryButton.heightAnchor.constraint(equalToConstant: 50),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16)
        ])
    }
    
    @objc private func retryButtonTapped(_ sender: UIButton) {
        delegate?.errorViewDidTapRetry()
    }
        
}

// MARK: - UI
extension ErrorView {
    
    private func createErrorImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = viewModel.errorImage
        return imageView
    }
    
    private func createRetryButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(viewModel.retryButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(retryButtonTapped(_:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderColor = NewsColor.Primary.Borders.mainColor.cgColor
        button.layer.borderWidth = 0.3
        return button
    }
    
}
