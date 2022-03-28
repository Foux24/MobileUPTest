//
//  JsonModelValidationToken.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import Foundation

// MARK: - JsonModelValidationToken
struct JsonModelValidationToken: Codable {
    let response: ValidToken
}

// MARK: - Response
struct ValidToken: Codable {
    let date, expire, success, userID: Int

    enum CodingKeys: String, CodingKey {
        case date, expire, success
        case userID = "user_id"
    }
}
