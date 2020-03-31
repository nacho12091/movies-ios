//
//  UIColor.swift
//  Movies
//
//  Created by Ignacio Lima on 8/8/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let cellBackground = UIColor(red: 242, green: 242, blue: 242, a: 1.0)

    static let tabBarUnselectedItemColor = UIColor(red: 1, green: 210, blue: 119, a: 0.5)

    static let darkBackground = UIColor(red: 10, green: 28, blue: 36, a: 1.0)

    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
}
