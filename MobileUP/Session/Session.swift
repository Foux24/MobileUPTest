//
//  Session.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit
import WebKit

class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token: String = "95dd948148375865e2d8cd01275a0325ff6eddaab1cba64ed85451b7a4c81681428a24e6bf97264ddf445"
    var userId: Int = 184658240
    
//    var token: String?
//    var userId: Int?
    
    /// Метод для выхода из аккаунта
    func clean() {
//        self.token = nil
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
}
