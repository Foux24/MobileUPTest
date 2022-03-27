//
//  DetailPhotoPresentor.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

/// Протокол для общения контроллера с презентором
protocol DetailPhotoPresentorOutput: AnyObject {
    func formateDate(date: Int) -> String
    var fileManager: HashPhotoService? { get set }
}

// MARK: - DetailPhotoPresentor
final class DetailPhotoPresentor: DetailPhotoPresentorOutput {
    
    /// Для кеша изоборажений
    var fileManager: HashPhotoService?
    
    /// форматер преобразования даты
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy"
        df.locale = Locale(identifier: "ru_RU")
        df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return df
    }()
    
    /// Метод для конвертации даты
    func formateDate(date: Int) -> String {
        var dateFormate = ""
        let date = NSDate(timeIntervalSince1970: TimeInterval(date))
        let dateString = self.dateFormatter.string(from: date as Date)
        dateFormate = dateString
        return dateFormate
    }
}

private extension DetailPhotoPresentor {
    
}
