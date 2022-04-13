//
//  DetailPhotoView.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

// MARK: - DetailPhotoView
final class DetailPhotoView: UIView {
    
    /// UIImage
    private(set) lazy var photoView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    /// UICollectionView
    private(set) lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    /// инициализтор
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstreints()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Private
private extension DetailPhotoView {
    
    /// Настройка вью
    func setupView() {
        self.backgroundColor = .white
    }
    
    /// Добавим UI на View
    func setupUI() {
        self.addSubview(photoView)
        self.addSubview(collectionView)
    }
    
    /// Настроим констрейнты
    func setupConstreints() {
        NSLayoutConstraint.activate([
            photoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -34),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -40),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    /// Настроим композицию элементов в коллекции
    func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 2
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
