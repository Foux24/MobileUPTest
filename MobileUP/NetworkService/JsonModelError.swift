//
//  JsonModelError.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import Foundation

// MARK: - Errors
struct Errors: Codable {
    let error: ErrorVK
}

// MARK: - Error
struct ErrorVK: Codable {
    let errorCode: Int

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}
