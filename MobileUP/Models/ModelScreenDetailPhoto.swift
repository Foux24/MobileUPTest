//
//  ModelScreenDetailPhoto.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit
/// Структура для передачи ее на экран с Деталями фото
struct ModelScreenDetailPhoto {
    
    /// Свойство выбраной фотографии с коллекции
    let selectPhoto: ModelSortedPhoto
    
    /// Массив со всеми фото
    let arrayPhoto: [ModelSortedPhoto]
}
