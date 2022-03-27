//
//  DetailPhotoViewController.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

// MARK: - DetailPhotoViewController
final class DetailPhotoViewController: UIViewController {
    
    /// Презентор
    private var presentor: DetailPhotoPresentorOutput
    
    /// Инициализтор
    init(presentor: DetailPhotoPresentorOutput) {
        self.presentor = presentor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// UIView
    private var detailPhotoView: DetailPhotoView {
        return self.view as! DetailPhotoView
    }
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        self.view = DetailPhotoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollection()
        self.detailPhotoView.photoView.loadImage(presentor.data.selectPhoto.url)
        self.presentor.fileManager = HashPhotoService(container: detailPhotoView.collectionView)
        self.presentor.setupController()
    }
}

//MARK: - UITableViewDataSource
extension DetailPhotoViewController: UICollectionViewDataSource {
    
    /// Кол-во итемов в секции коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presentor.data.arrayPhoto.count
    }
    
    /// Данные для итема
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = detailPhotoView.collectionView.dequeueReusableCell(forIndexPath: indexPath) as DetailPhotoCollectionViewCell
        let image = self.presentor.fileManager?.photo(atIndexPath: indexPath, byUrl: presentor.data.arrayPhoto[indexPath.row].url)
        cell.configureImage(with: image)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension DetailPhotoViewController: UICollectionViewDelegate {
    
    /// Действие при выделении итема
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = presentor.data.arrayPhoto[indexPath.row]
        self.detailPhotoView.photoView.loadImage(photo.url)
        self.navigationItem.title = "\(presentor.formateDate(date: photo.dateCreate))"
    }
}

// MARK: - Private
private extension DetailPhotoViewController {
    
    /// Настроим Коллекцию
    func setupCollection() {
        self.detailPhotoView.collectionView.registerCell(DetailPhotoCollectionViewCell.self)
        self.detailPhotoView.collectionView.dataSource = self
        self.detailPhotoView.collectionView.delegate = self
    }
}
