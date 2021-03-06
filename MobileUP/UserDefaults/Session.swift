//
//  Session.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit
import WebKit

// MARK: - Session
final class Session {
    
    /// Singlton для доступа к классу
    static let instance = Session()
    
    /// Свойство для хранения файла сессии
    private(set) var session: DataSession {
        didSet {
            sessionCaretaker.save(session: session)
        }
    }

    /// Инициализтор
    private init(){
        self.session = self.sessionCaretaker.retrieveSession()
    }
    
    /// Экземпляр класса настроек
    private let sessionCaretaker = SessionCaretaker()
    
    /// Метод для добавления настроек
    func addSession(_ session: DataSession) {
        self.session = session
    }

    /// Метод для выхода из аккаунта
    func cleanSession() {
        self.session.token = nil
        self.session.userId = nil
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}
