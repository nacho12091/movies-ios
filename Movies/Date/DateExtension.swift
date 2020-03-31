//
//  DateExtension.swift
//  Movies
//
//  Created by Ignacio Lima on 8/28/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: String = Constants.dateFormats.first) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func changeFormat() -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = Constants.dateFormats.second
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = Constants.dateFormats.first
        let finalDate = dateFormatterGet.string(from: self)
        let fDate = dateFormatterPrint.date(from: finalDate) ?? self
        return(fDate)
    }
    
}
