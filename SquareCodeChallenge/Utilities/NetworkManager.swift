//
//  NetworkManager.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-16.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let employeeURL = URL(string: ApiUrl.shared.employeeListAPI)!
    
    private init() {}
    
    func getEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) {
        URLSession.shared.dataTask(with: employeeURL) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(EmployeeResponse.self, from: data)
                completion(.success(response.employees))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct EmployeeResponse: Codable {
    let employees: [Employee]
}

enum NetworkError: Error {
    case noData
}
