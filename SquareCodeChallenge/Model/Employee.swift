//
//  Employee.swift
//  SquareCodeChallenge
//
//  Created by Khadija Daruwala on 2023-07-15.
//

import Foundation

struct Employee : Codable {
    let uuid : String?
    let fullName : String?
    let phoneNumber : String?
    let emailAddress : String?
    let biography : String?
    let photoUrlSmall : String?
    let photoUrlLarge : String?
    let team : String?
    let employeeType : String?
    
    enum CodingKeys: String, CodingKey {
        
        case uuid = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography = "biography"
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team = "team"
        case employeeType = "employee_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        emailAddress = try values.decodeIfPresent(String.self, forKey: .emailAddress)
        biography = try values.decodeIfPresent(String.self, forKey: .biography)
        photoUrlSmall = try values.decodeIfPresent(String.self, forKey: .photoUrlSmall)
        photoUrlLarge = try values.decodeIfPresent(String.self, forKey: .photoUrlLarge)
        team = try values.decodeIfPresent(String.self, forKey: .team)
        employeeType = try values.decodeIfPresent(String.self, forKey: .employeeType)
    }
    
}
enum EmployeeType: String, Codable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}
