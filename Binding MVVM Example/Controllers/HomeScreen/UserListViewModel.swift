//
//  UserListViewModel.swift
//  Binding MVVM Example
//
//  Created by Okan Orkun on 15.03.2024.
//

import Foundation

struct UserListViewModel {
    
    private var networkManager: NetworkManager
    
    var users: Observable<[UserTableViewCellViewModel]> = Observable([])
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchUserData() {
        networkManager.request(endpoint: .fetchData) { data, error in
            DispatchQueue.main.async {
                if let data = data {
                    handleNetworkResponse(data: data, error: error)
                }
            }
        }
    }
    
    private func handleNetworkResponse(data: Data?, error: Error?) {
        guard let data = data else { return }
        do {
            let userModels = try JSONDecoder().decode([User].self, from: data)
            users.value = userModels.compactMap({
                UserTableViewCellViewModel(name: $0.name)
            })
        } catch {
            print("Error")
        }
    }
}

struct UserTableViewCellViewModel {
    let name: String
}
