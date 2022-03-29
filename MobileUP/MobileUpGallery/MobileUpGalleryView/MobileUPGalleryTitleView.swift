//
//  MobileUPGalleryTitleView.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - MobileUPGalleryTitleView
final class MobileUPGalleryTitleView: UIView {
   
    /// Title
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .customBlackColor
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mobile Up Gallery"
        return label
    }()
    
    
    /// Инициализтор
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setUIElementsInView()
        self.setConstreints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private
private extension MobileUPGalleryTitleView {
    
    /// Настройка View
    func setupView() {
        self.backgroundColor = .clear
    }
    
    /// Добавления элементов на вью
    func setUIElementsInView() {
        self.addSubview(titleLabel)
    }
    
    /// Растановка констрейнтов
    func setConstreints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
