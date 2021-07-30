//
//  RxAlamofireApi.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/27.
//

import Foundation
import Moya

enum APIService {
    case yellowFlowers(query: [String : Any])
    case blueFlowers(query: [String : Any])
}

extension APIService: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://pixabay.com") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .yellowFlowers(_), .blueFlowers(_):
            return "/api"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .yellowFlowers(_), .blueFlowers(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .yellowFlowers(var query):
            query["key"] = "22667147-c3257995719131997e3685129"
            return .requestParameters(parameters: query,
                                      encoding: URLEncoding.default)
        case .blueFlowers(var query):
            query["key"] = "22667147-c3257995719131997e3685129"
            return .requestParameters(parameters: query,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .yellowFlowers(_), .blueFlowers(_):
            return nil // ["Content-Type" : "application/json"]
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    
}
