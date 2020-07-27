// swiftlint:disable nesting
//
//  NewsColor.swift
//  NewsUIKit
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

public struct NewsColor {
    
    public struct Primary {
        public static let green: UIColor = UIColor(hex: "#6BD950")
        public static let greenLight: UIColor = UIColor(hex: "#6BD950").withAlphaComponent(0.5)
        
        public struct Borders {
            public static let mainColor: UIColor = UIColor.black.withAlphaComponent(0.5)
        }
        
        public struct Separators {
            public static let mainColor: UIColor = UIColor.black.withAlphaComponent(0.2)
        }
    }
    
}
