//
//  SessionCaretaker.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import Foundation

// MARK: - Records Save
final class SessionCaretaker {
    
    /// Определим свойства кодера и декодера
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    ///  Опеределим ключ по которому будет обращаться для запроса данных
    private let key = "session"
    
    /// Сохранение сессии в память
    func save(session: DataSession) {
        do {
            let data = try self.encoder.encode(session)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    /// Загрузка данных сессии из памяти
    func retrieveSession() -> DataSession {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            let session = DataSession(token: nil, userId: nil)
            return session
        }
        do {
            return try self.decoder.decode(DataSession.self, from: data)
        } catch {
            print(error)
            let session = DataSession(token: nil, userId: nil)
            return session
        }
    }
}
