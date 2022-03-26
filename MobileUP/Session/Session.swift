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
    
//    var token: String = "4b2bd7032a520180ec58ddb4b722a5deefe34df8dba282a217ae2606a35f68fc2f3a7ccbadbc51be848c3"
//    var userId: Int = 184658240
    
    var token: String?
    var userId: Int?
    
    /// Метод для выхода из аккаунта
    func clean() {
        self.token = nil
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
}
