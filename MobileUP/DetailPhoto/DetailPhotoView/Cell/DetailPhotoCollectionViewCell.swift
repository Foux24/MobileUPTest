//
//  DetailPhotoCollectionViewCell.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

// MARK: - DetailPhotoCollectionViewCell
final class DetailPhotoCollectionViewCell: UICollectionViewCell {
    
    /// Ключ для регистрации ячкйки
    static let reuseID = String(describing: DetailPhotoCollectionViewCell.self)

    /// UIImage
    private(set) lazy var photoView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    /// Конфигурирует данными ячейку
    func configureImage(with image: UIImage?) {
        guard let imageDefault = UIImage(systemName: "photo") else { return }
        photoView.image = image ?? imageDefault
        setupUI()
        setupConstraints()
    }
    
}

// MARK: - Private
private extension DetailPhotoCollectionViewCell {

    /// Добавим UI на contentView
    func setupUI() {
        contentView.addSubview(photoView)
    }
    
    /// Метод установки констрейнтов
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
