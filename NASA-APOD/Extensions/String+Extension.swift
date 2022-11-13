//
//  String+Extension.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import Foundation

extension String {
    func toDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
}
