//
//  ApiUrl.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-16.
//

import Foundation
class ApiUrl {
    static let domain = "https://s3.amazonaws.com/sq-mobile-interview/"
    let employeeListAPI = domain + "employees.json"
    let malformedEmployeeListAPI = domain + "employees_malformed.json"
    let emptyEmployeeListAPI = domain + "employees_empty.json"
    
    static let shared = ApiUrl()
}
