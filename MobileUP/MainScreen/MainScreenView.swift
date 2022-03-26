//
//  MainScreenView.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

final class MainScreenView: UIView {
    
    /// Заголовок главного экрана
    private(set) lazy var headerMainScreenLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor.textColorHeaderMainScreen
        label.font = UIFont(name: "SFProDisplay-Bold", size: 48)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mobile Up\nGallery"
        return label
    }()

    /// Инициализтор
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUIElementsInView()
        self.setConstreints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MainScreenView {
    
    /// Добавления элементов на вью
    func setUIElementsInView() {
        self.backgroundColor = .white
        self.addSubview(headerMainScreenLabel)
    }
    
    /// Растановка констрейнтов
    func setConstreints() {
        NSLayoutConstraint.activate([
            headerMainScreenLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 164),
            headerMainScreenLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            headerMainScreenLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
        ])
    }
}
