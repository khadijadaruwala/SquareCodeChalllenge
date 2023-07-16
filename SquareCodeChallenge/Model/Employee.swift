//
//  Employee.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-15.
//

import Foundation

struct Employee: Codable {
    let uuid: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoURLSmall: String?
    let photoURLLarge: String?
    let team: String
    let employeeType: EmployeeType
}

enum EmployeeType: String, Codable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}
