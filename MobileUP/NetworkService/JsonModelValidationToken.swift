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
    let success: Int

    enum CodingKeys: String, CodingKey {
        case success
    }
}
