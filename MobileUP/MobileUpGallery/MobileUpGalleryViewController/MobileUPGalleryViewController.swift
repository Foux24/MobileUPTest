//
//  MobileUPGalleryViewController.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - MobileUPGalleryViewController
final class MobileUPGalleryViewController: UIViewController {
    
    /// Массив с фотографиями
    var photos = [ModelSortedPhoto]() {
        didSet {
            self.mobileUpGalleryView.collectionView.reloadData()
        }
    }
    
    /// UIView
    private var mobileUpGalleryView: MobileUPGalleryView {
        return self.view as! MobileUPGalleryView
    }
    
    /// Презентор
    private let presentor: MobileUPGalleryPresentorOutput
    
    /// Инициализтор
    init(presentor: MobileUPGalleryPresentorOutput) {
        self.presentor = presentor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = MobileUPGalleryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Session.instance.session.token!)
        setupCollection()
        presentor.fileManager = HashPhotoService(container: mobileUpGalleryView.collectionView)
        presentor.getPhotoAlbum()
        presentor.setupController()
    }
}

//MARK: - UITableViewDataSource
extension MobileUPGalleryViewController: UICollectionViewDataSource {
    
    /// Кол-во итемов в секции коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    /// Данные для итема
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mobileUpGalleryView.collectionView.dequeueReusableCell(forIndexPath: indexPath) as MobileUpGalleryUICollectionViewCell
        let image = self.presentor.fileManager?.photo(atIndexPath: indexPath, byUrl: photos[indexPath.row].url)
        cell.configureImage(with: image)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MobileUPGalleryViewController: UICollectionViewDelegate {
    
    /// Действие при выделении итема
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presentor.showDetailPhoto(data: ModelScreenDetailPhoto(selectPhoto: photos[indexPath.row], arrayPhoto: photos))
    }
}

/// Подпишем контроллер на протокол
extension MobileUPGalleryViewController: MobileUPGalleryPresentorInput {}

// MARK: - Private
private extension MobileUPGalleryViewController {
    
    /// Настроим Коллекцию
    func setupCollection() {
        self.mobileUpGalleryView.collectionView.registerCell(MobileUpGalleryUICollectionViewCell.self)
        self.mobileUpGalleryView.collectionView.delegate = self
        self.mobileUpGalleryView.collectionView.dataSource = self
    }
}
