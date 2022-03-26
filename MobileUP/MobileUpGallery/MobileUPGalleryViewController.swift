//
//  MobileUPGalleryViewController.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

final class MobileUPGalleryViewController: UIViewController {
    
    /// Массив с фотографиями
    var photos = [Item]() {
        didSet {
            print(photos)
        }
    }
    
    /// Презентор
    private let presentor: MobileUPGalleryPresentorOutput
    
    /// Инициализтор
    init(presentor: MobileUPGalleryPresentorOutput) {
        self.presentor = presentor
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentor.getPhotoAlbum()
    }
}

extension MobileUPGalleryViewController: MobileUPGalleryPresentorInput {}
