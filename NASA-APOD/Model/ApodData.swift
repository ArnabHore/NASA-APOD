//
//  ApodData.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import Foundation

struct ApodData: Codable {
    let copyright: String?
    let date: String?
    let explanation: String?
    let hdurl: String?
    let mediaType: String?
    let serviceVersion: String?
    let title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
