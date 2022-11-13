//
//  Date+Extension.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import Foundation

extension Date {
    func toDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
}
