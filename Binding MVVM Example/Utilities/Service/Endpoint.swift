//
//  Endpoint.swift
//  Binding MVVM Example
//
//  Created by Okan Orkun on 15.03.2024.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get
    
    var HTTPValue: String {
        return self.rawValue.uppercased()
    }
}

enum Endpoint {
    case fetchData
}

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        return AppConstants.NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchData:
            return AppConstants.NetworkConstants.users
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchData:
            return .get
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    func request() -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
    
}
