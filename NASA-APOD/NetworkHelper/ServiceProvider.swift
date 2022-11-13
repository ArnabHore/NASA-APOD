//
//  ServiceProvider.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import Foundation
import Alamofire

class NetworkHelper {
    func callApiWith(task: Task, parameters: Parameters?, _ completion: @escaping (Data?, Error?) -> Void) {
        let url = Constants.baseUrl + task.url
        let request = AF.request(url, method: task.method, parameters: parameters)
        request.response { response in
            switch response.result {
            case let .success(result):
                completion(result, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
        completion(nil, nil)
    }
}
