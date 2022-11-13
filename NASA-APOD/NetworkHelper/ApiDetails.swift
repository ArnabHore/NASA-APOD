//
//  ApiDetails.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import Foundation
import Alamofire

enum Task {
    case apod
    
    var url: String {
        switch self {
        case .apod:
            return "/planetary/apod"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .apod:
            return .get
        }
    }
}
