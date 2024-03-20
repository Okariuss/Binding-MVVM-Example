//
//  NetworkManager.swift
//  Binding MVVM Example
//
//  Created by Okan Orkun on 15.03.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func request(endpoint: Endpoint, completion: @escaping (Data?, Error?) -> Void) {
        let request = endpoint.request()
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }
        dataTask.resume()
    }
}
