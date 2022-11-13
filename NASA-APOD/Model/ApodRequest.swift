//
//  ApodRequest.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import Foundation

struct ApodRequest: Encodable {
    let api_key: String
    let date: String?
}
