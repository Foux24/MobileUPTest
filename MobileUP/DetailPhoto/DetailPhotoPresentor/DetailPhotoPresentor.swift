//
//  DetailPhotoPresentor.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

/// Протокол для общения контроллера с презентором
protocol DetailPhotoPresentorOutput: AnyObject {
    var fileManager: HashPhotoService? { get set }
    var data: ModelScreenDetailPhoto { get set }
    func formateDate(date: Int) -> String
    func setupController() -> Void 
}

// MARK: - DetailPhotoPresentor
final class DetailPhotoPresentor: DetailPhotoPresentorOutput {
    
    /// Для кеша изоборажений
    var fileManager: HashPhotoService?
    
    /// ViewController
    weak var viewController: UIViewController?
    
    /// Данные фото
    var data: ModelScreenDetailPhoto
    
    private let intercator: DetailPhotoInteractorInput
    
    /// Инициализтор
    init(data: ModelScreenDetailPhoto, intercator: DetailPhotoInteractorInput) {
        self.data = data
        self.intercator = intercator
    }
    
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
    
    /// Настройка контроллера
    func setupController() -> Void {
        viewController?.navigationItem.title = "\(formateDate(date: data.selectPhoto.dateCreate))"
        viewController?.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        viewController?.navigationController?.navigationBar.tintColor = .customBlackColor
        viewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Vector"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(getAlert))
    }
}

// MARK: - Private
private extension DetailPhotoPresentor {
    
    /// Алерт sheet
    @objc func getAlert() -> Void {
        let alertController = UIAlertController()
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        let saveAction = UIAlertAction(title: "Добавить в Сохраненные", style: .default) { (result : UIAlertAction) -> Void in
            self.savePhoto()
        }
        
        let shareAction = UIAlertAction(title: "Поделиться", style: .default) { (result : UIAlertAction) -> Void in
            // ПО ТЗ реализации действия поделиться фото не требуется, Сделаю просто алерт
            self.getAlertSharePhoto()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        alertController.addAction(shareAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }
    func savePhoto() {
        self.intercator.savePhoto(dataPhoto: data.selectPhoto) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.getAlertSavePhoto()
            case .failure(let error):
                self.getErrorAlertSavePhoto(message: error)
            }
        }
    }
    
    /// Алерт с сохранением фото
    func getAlertSavePhoto() -> Void {
        let alert = UIAlertController(title: "Сохранено", message: "Фото добавленно в сохраненные", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    /// Алерт с сохранением фото
    func getErrorAlertSavePhoto(message: Error) -> Void {
        let alert = UIAlertController(title: "Error", message: "\(message)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    /// Алерт с поделиться фото
    func getAlertSharePhoto() -> Void {
        let alert = UIAlertController(title: "Поделиться", message: "Поделиться", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    
}
