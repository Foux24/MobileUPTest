//
//  DetailPhotoBuilder.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

// MARK: - MobileUPGalleryBuilder
class DetailPhotoBuilder {
    
    /// Билд контроллера
    static func build(data: ModelScreenDetailPhoto) -> UIViewController {
        let presenter = DetailPhotoPresentor()
        let viewController = DetailPhotoViewController(data: data, presentor: presenter)
        return viewController
    }
}
