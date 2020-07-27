//
//  ErrorViewViewModel.swift
//  NewsUIKit
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

public struct ErrorViewViewModel {
    let retryButtonTitle: String
    let errorImage: UIImage
    
    public init(retryButtonTitle: String, errorImage: UIImage) {
        self.retryButtonTitle = retryButtonTitle
        self.errorImage = errorImage
    }
}
